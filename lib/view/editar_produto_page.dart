import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/produto.dart';
import 'package:pedido/repositories/produto_repository.dart';

class EditarProdutoPage extends StatefulWidget {
  static const String routeNameP = '/editProduto';
  @override
  _EditarProdutoState createState() => _EditarProdutoState();
}

class _EditarProdutoState extends State<EditarProdutoPage> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  //final _sobrenomeController = TextEditingController();
  //final _cpfController = TextEditingController();
  int _id = 0;
  Produto? _produto;

//DISPOSE
  @override
  void dispose() async {
    _descricaoController.dispose();
    //_sobrenomeController.dispose();
    // _cpfController.dispose();
    super.dispose();
  }

//OBTER ANTIGO - SEM REST
  /*void _obterBoi() async {
    this._boi = Boi(this._id, "Boi ${this._id}", "Raça", 10);
    _descricaoController.text = this._boi!.descricao;
    _racaController.text = this._boi!.raca;
    _idadeController.text = this._boi!.idade.toString();
  }*/

  //OBTER NOVO - COM REST
  void _obterProduto() async {
    try {
      ProdutoRepository repository = ProdutoRepository();
      this._produto = await repository.buscar(this._id);
      _descricaoController.text = this._produto!.descricao;
      //_sobrenomeController.text = this._produto!.sobrenome;
      //_cpfController.text = this._produto!.cpf;
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

    _descricaoController.text = this._boi.descricao;
    _descricaoController.text = this._boi.raca;
    _descricaoController.text = this._boi.idade.toString();

    try {
      ProdutoRepository repository = ProdutoRepository();
      this._boi = await repository.buscar(this._id);
      _descricaoController.text = this._boi!.descricao;
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
    this._boi!.descricao = _descricaoController.text;
    this._boi!.raca = _racaController.text;
    this._boi!.idade = int.parse(_idadeController.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi editado com sucesso.')));
  }
  */

//SALVAR NOVO - COM REST
  void _salvar() async {
    this._produto!.descricao = _descricaoController.text;
    //this._produto!.sobrenome = _sobrenomeController.text;
    //this._produto!.cpf = _cpfController.text;

    try {
      ProdutoRepository repository = ProdutoRepository();
      await repository.alterar(this._produto!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cliente editado com sucesso')));
    } catch (exception) {
      showError(context, "Erro editando cliente", exception.toString());
    }
  }

// CRUD | editar_boi_page.dart DAO
/*-
  void _salvar() async {
    this._boi.descricao = _descricaoController.text;
    this._boi.raca = _racaController.text;
    this._boi.idade = int.parse(_idadeController.text);
  }  */

  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Descricao:"),
              Expanded(
                  child: TextFormField(
                controller: _descricaoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            /* Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Sobredescricao:"),
              Expanded(
                  child: TextFormField(
                controller: _sobrenomeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("CPF:"),
              Expanded(
                  child: TextFormField(
                controller: _cpfController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
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
    _obterProduto();

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Produto"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}

//falta metodo show erro pg523