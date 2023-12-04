import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/pedido.dart';
import 'package:pedido/repositories/pedido_repository.dart';

class EditarPedidoPage extends StatefulWidget {
  static const String routeNamePdd = '/editPedido';
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

//OBTER ANTIGO - SEM REST
  /*void _obterBoi() async {
    this._boi = Boi(this._id, "Boi ${this._id}", "Raça", 10);
    _dataController.text = this._boi!.data;
    _racaController.text = this._boi!.raca;
    _idadeController.text = this._boi!.idade.toString();
  }*/

  //OBTER NOVO - COM REST
  void _obterPedido() async {
    try {
      PedidoRepository repository = PedidoRepository();
      this._pedido = await repository.buscar(this._id);
      _dataController.text = this._pedido!.data;
      _idprodutoController.text = this._pedido!.idproduto;
      _quantidadeController.text = this._pedido!.quantidade;
    } catch (exception) {
      showError(context, "Erro recuperando cliente", exception.toString());
      Navigator.pop(context);
    }
  }

//CRUD | editar_boi_page.dart//DAO
/*
  void _obterBoi() async {
    Database db = await ConennectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);
    this._boi = await dao.obterPorId(this._id);

    ConennectionFactory.factory.close();

    _dataController.text = this._boi.data;
    _dataController.text = this._boi.raca;
    _dataController.text = this._boi.idade.toString();

    try {
      PedidoRepository repository = PedidoRepository();
      this._boi = await repository.buscar(this._id);
      _dataController.text = this._boi!.data;
      _racaController.text = this._boi!.raca;
      _idadeController.text = this._boi!.idade.toString();
    } catch (exception) {
      showError(context, "Erro recuperando boi", exception.toString());
      Navigator.pop(context);
    }
  }
*/
//SALVAR ANTIGO - SEM REST
  /* void _salvar() async {
    this._boi!.data = _dataController.text;
    this._boi!.raca = _racaController.text;
    this._boi!.idade = int.parse(_idadeController.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi editado com sucesso.')));
  }
  */

//SALVAR NOVO - COM REST
  void _salvar() async {
    this._pedido!.data = _dataController.text;
    this._pedido!.idproduto = _idprodutoController.text;
    this._pedido!.quantidade = _quantidadeController.text;

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
/*-
  void _salvar() async {
    this._boi.data = _dataController.text;
    this._boi.raca = _racaController.text;
    this._boi.idade = int.parse(_idadeController.text);
  }  */

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
            /*
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Idade"),
              Expanded(
                  child: TextFormField(
                controller: _idadeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),*/
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

//falta metodo show erro pg523