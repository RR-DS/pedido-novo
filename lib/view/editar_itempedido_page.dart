import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/itempedido.dart';
import 'package:pedido/repositories/itempedido_repository.dart';

class EditarItempedidoPage extends StatefulWidget {
  static const String routeNameItempdd = '/editItempdd';
  @override
  _EditarItempedidoState createState() => _EditarItempedidoState();
}

class _EditarItempedidoState extends State<EditarItempedidoPage> {
  final _formKey = GlobalKey<FormState>();
  final _idpedidoController = TextEditingController();
  final _idprodutoController = TextEditingController();
  final _qtdadeController = TextEditingController();
  int _id = 0;
  Itempedido? _itempedido;

//DISPOSE
  @override
  void dispose() async {
    _idpedidoController.dispose();
    _idprodutoController.dispose();
    _qtdadeController.dispose();
    super.dispose();
  }

//OBTER ANTIGO - SEM REST
  /*void _obterBoi() async {
    this._boi = Boi(this._id, "Boi ${this._id}", "Raça", 10);
    _idpedidoController.text = this._boi!.data;
    _racaController.text = this._boi!.raca;
    _idadeController.text = this._boi!.idade.toString();
  }*/

  //OBTER NOVO - COM REST
  void _obterItempedido() async {
    try {
      ItempedidoRepository repository = ItempedidoRepository();
      this._itempedido = await repository.buscar(this._id);
      _idpedidoController.text = this._itempedido!.idpedido.toString();
      _idprodutoController.text = this._itempedido!.idproduto.toString();
      _qtdadeController.text = this._itempedido!.qtdade.toString();
      //_qtdadeController.text = this._pedido!.qtdade;
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

    _idpedidoController.text = this._boi.data;
    _idpedidoController.text = this._boi.raca;
    _idpedidoController.text = this._boi.idade.toString();

    try {
      ItempedidoRepository repository = ItempedidoRepository();
      this._boi = await repository.buscar(this._id);
      _idpedidoController.text = this._boi!.data;
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
    this._boi!.data = _idpedidoController.text;
    this._boi!.raca = _racaController.text;
    this._boi!.idade = int.parse(_idadeController.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi editado com sucesso.')));
  }
  */

//SALVAR NOVO - COM REST
  void _salvar() async {
    this._itempedido!.idpedido = int.parse(_idpedidoController.text);
    this._itempedido!.idproduto = int.parse(_idprodutoController.text);
    this._itempedido!.qtdade = int.parse(_qtdadeController.text);

    try {
      ItempedidoRepository repository = ItempedidoRepository();
      await repository.alterar(this._itempedido!);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item do pedido editado com sucesso')));
    } catch (exception) {
      showError(context, "Erro editando Item do Pedido", exception.toString());
    }
  }

// CRUD | editar_boi_page.dart DAO
/*-
  void _salvar() async {
    this._boi.data = _idpedidoController.text;
    this._boi.raca = _racaController.text;
    this._boi.idade = int.parse(_idadeController.text);
  }  */

  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Id Pedido:"),
              Expanded(
                  child: TextFormField(
                controller: _idpedidoController,
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
                controller: _qtdadeController,
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
    _obterItempedido();

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Item do Pedido"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}

//falta metodo show erro pg523