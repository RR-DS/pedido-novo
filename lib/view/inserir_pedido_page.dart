import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/pedido.dart';
import 'package:pedido/repositories/pedido_repository.dart';

class InserirPedidoPage extends StatefulWidget {
  static const String routeNamePdd = '/insertPedido';

  @override
  _InserirPedidoState createState() => _InserirPedidoState();
}

//INSERIRBOIDART
class _InserirPedidoState extends State<InserirPedidoPage> {
  final _formKey = GlobalKey<FormState>();
  final _dataController = TextEditingController();
  final _idprodutoController = TextEditingController();
  final _quantidadeController = TextEditingController();

  @override
//DISPOSE
  void dispose() {
    _dataController.dispose();
    _idprodutoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

//SALVAR - INT COM BANCO - ANTIGO
  /* void _salvar() async {
    _dataController.clear();
    _racaController.clear();
    _idadeController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi salvo com sucesso')));
  }
*/
  //SALVAR - INT COM BANCO - NOVO

  //--- SALVAR ANTIGO----

  void _salvar() async {
    Pedido pedido = Pedido.novo(_dataController.text, _idprodutoController.text,
        _quantidadeController.text);

    try {
      PedidoRepository repository = PedidoRepository();
      await repository.inserir(pedido);
      _dataController.clear();
      _idprodutoController.clear();
      _quantidadeController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pedido salvo com sucesso')));
    } catch (exception) {
      showError(context, "Erro inserindo pedido", exception.toString());
    }
  }

//SALVAR NOVO
/*
  void _salvar() async {
    Database db = await ConennectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);
    Boi boi = Pedido.novo(_dataController.text, _racaController.text,
        int.parse(_idadeController.text));
    await dao.inserir(boi);
    ConennectionFactory.factory.close();
    _dataController.clear();
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
                Text('Data'),
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
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Id Produto'),
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
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Quantidade'),
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
        title: Text("Inserir Pedido"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}
