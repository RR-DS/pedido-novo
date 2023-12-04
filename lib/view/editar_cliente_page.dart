import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/cliente.dart';
import 'package:pedido/repositories/cliente_repository.dart';

class EditarClientePage extends StatefulWidget {
  static const String routeName = '/edit';
  @override
  _EditarClienteState createState() => _EditarClienteState();
}

class _EditarClienteState extends State<EditarClientePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _cpfController = TextEditingController();
  int _id = 0;
  Cliente? _cliente;

//DISPOSE
  @override
  void dispose() async {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

//OBTER ANTIGO - SEM REST
  /*void _obterBoi() async {
    this._boi = Boi(this._id, "Boi ${this._id}", "Raça", 10);
    _nomeController.text = this._boi!.nome;
    _racaController.text = this._boi!.raca;
    _idadeController.text = this._boi!.idade.toString();
  }*/

  //OBTER NOVO - COM REST
  void _obterCliente() async {
    try {
      ClienteRepository repository = ClienteRepository();
      this._cliente = await repository.buscar(this._id);
      _nomeController.text = this._cliente!.nome;
      _sobrenomeController.text = this._cliente!.sobrenome;
      _cpfController.text = this._cliente!.cpf;
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

    _nomeController.text = this._boi.nome;
    _nomeController.text = this._boi.raca;
    _nomeController.text = this._boi.idade.toString();

    try {
      ClienteRepository repository = ClienteRepository();
      this._boi = await repository.buscar(this._id);
      _nomeController.text = this._boi!.nome;
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
    this._boi!.nome = _nomeController.text;
    this._boi!.raca = _racaController.text;
    this._boi!.idade = int.parse(_idadeController.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi editado com sucesso.')));
  }
  */

//SALVAR NOVO - COM REST
  void _salvar() async {
    this._cliente!.nome = _nomeController.text;
    this._cliente!.sobrenome = _sobrenomeController.text;
    this._cliente!.cpf = _cpfController.text;

    try {
      ClienteRepository repository = ClienteRepository();
      await repository.alterar(this._cliente!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cliente editado com sucesso')));
    } catch (exception) {
      showError(context, "Erro editando cliente", exception.toString());
    }
  }

// CRUD | editar_boi_page.dart DAO
/*-
  void _salvar() async {
    this._boi.nome = _nomeController.text;
    this._boi.raca = _racaController.text;
    this._boi.idade = int.parse(_idadeController.text);
  }  */

  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Nome:"),
              Expanded(
                  child: TextFormField(
                controller: _nomeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ))
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Sobrenome:"),
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
    _obterCliente();

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Cliente"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}

//falta metodo show erro pg523