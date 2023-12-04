import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/cliente.dart';
import 'package:pedido/repositories/cliente_repository.dart';

class InserirClientePage extends StatefulWidget {
  static const String routeName = '/insert';

  @override
  _InserirClienteState createState() => _InserirClienteState();
}

//INSERIRBOIDART
class _InserirClienteState extends State<InserirClientePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _cpfController = TextEditingController();

  @override
//DISPOSE
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

//SALVAR - INT COM BANCO - ANTIGO
  /* void _salvar() async {
    _nomeController.clear();
    _racaController.clear();
    _idadeController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi salvo com sucesso')));
  }
*/
  //SALVAR - INT COM BANCO - NOVO

  //--- SALVAR ANTIGO----

  void _salvar() async {
    Cliente cliente = Cliente.novo(
        _nomeController.text, _sobrenomeController.text, _cpfController.text);

    try {
      ClienteRepository repository = ClienteRepository();
      await repository.inserir(cliente);
      _nomeController.clear();
      _sobrenomeController.clear();
      _cpfController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cliente salvo com sucesso')));
    } catch (exception) {
      showError(context, "Erro inserindo cliente", exception.toString());
    }
  }

//SALVAR NOVO
/*
  void _salvar() async {
    Database db = await ConennectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);
    Boi boi = Cliente.novo(_nomeController.text, _racaController.text,
        int.parse(_idadeController.text));
    await dao.inserir(boi);
    ConennectionFactory.factory.close();
    _nomeController.clear();
    _racaController.clear();
    _idadeController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi Salvo com sucesso.')));
  }
*/
//BUILDFORM
  Widget _buildForm(BuildContext context) {
    return Column(children: [
      Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Nome'),
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
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Sobrenome'),
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
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('CPF'),
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
              ],
            ),
            /*Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Idade'),
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
              ],
            ),*/
            Row(children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _salvar();
                  }
                },
                child: Text('Salvar'),
              ),
            ])
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inserir Cliente"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}
