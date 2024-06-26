import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/pedido.dart';
import 'package:pedido/repositories/pedido_repository.dart';

class EditarPedidoPage extends StatefulWidget {
  static const String routeNamePedido = '/editPedido';
  @override
  _EditarPedidoState createState() => _EditarPedidoState();
}

class _EditarPedidoState extends State<EditarPedidoPage> {
  final _formKey = GlobalKey<FormState>();
  final _dataController = TextEditingController();
  final _idprodutoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  int _id = 0;
  Pedido? _pedido;

//DISPOSE
  @override
  void dispose() async {
    _dataController.dispose();
    _idprodutoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  //OBTER NOVO - COM REST
  void _obterPedido() async {
    try {
      PedidoRepository repository = PedidoRepository();
      this._pedido = await repository.buscar(this._id);
      _dataController.text = this._pedido!.data;
      _idprodutoController.text = this._pedido!.idcliente.toString();
      //_quantidadeController.text = this._pedido!.quantidade;
    } catch (exception) {
      showError(context, "Erro recuperando cliente", exception.toString());
      Navigator.pop(context);
    }
  }

//SALVAR NOVO - COM REST
  void _salvar() async {
    this._pedido!.data = _dataController.text;
    this._pedido!.idcliente = int.parse(_idprodutoController.text);
    //this._pedido!.quantidade = _quantidadeController.text;

    try {
      PedidoRepository repository = PedidoRepository();
      await repository.alterar(this._pedido!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pedido editado com sucesso')));
    } catch (exception) {
      showError(context, "Erro editando cliente", exception.toString());
    }
  }

// CRUD | editar_boi_page.dart DAO

  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Data:"),
              Expanded(
                  child: TextFormField(
                controller: _dataController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Id Produto:"),
              Expanded(
                  child: TextFormField(
                controller: _idprodutoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Quantidade:"),
              Expanded(
                  child: TextFormField(
                controller: _quantidadeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _salvar();
                    }
                  },
                  child: Text('Salvar'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Map m = ModalRoute.of(context)!.settings.arguments as Map;
    this._id = m["id"];
    _obterPedido();

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Pedido"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}
