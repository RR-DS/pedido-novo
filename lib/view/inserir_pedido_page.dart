import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/pedido.dart';
import 'package:pedido/repositories/pedido_repository.dart';

class InserirPedidoPage extends StatefulWidget {
  static const String routeNamePedido = '/insertPedido';

  @override
  _InserirPedidoState createState() => _InserirPedidoState();
}

//INSERIRBOIDART
class _InserirPedidoState extends State<InserirPedidoPage> {
  final _formKey = GlobalKey<FormState>();
  final _dataController = TextEditingController();
  final _idclienteController = TextEditingController();
  //final _quantidadeController = TextEditingController();

  @override
//DISPOSE
  void dispose() {
    _dataController.dispose();
    _idclienteController.dispose();
    //_quantidadeController.dispose();
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
    Pedido pedido =
        Pedido.novo(_dataController.text, int.parse(_idclienteController.text));

    try {
      PedidoRepository repository = PedidoRepository();
      await repository.inserir(pedido);
      _dataController.clear();
      _idclienteController.clear();
      //_quantidadeController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pedido salvo com sucesso')));
    } catch (exception, s) {
      showError(context, "Erro inserindo pedido", exception.toString());
      showError(context, "Erro: $s", "");
    }
  }

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
                Text('Id Cliente'),
                Expanded(
                    child: TextFormField(
                  controller: _idclienteController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo não pode ser vazio';
                    }
                    return null;
                  },
                ))
              ],
            ),
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


//COMMIT DO DIA