import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/itempedido.dart';
import 'package:pedido/repositories/itempedido_repository.dart';

class InserirItempedidoPage extends StatefulWidget {
  static const String routeNameItem = '/insertItem';

  @override
  _InserirItempedidoState createState() => _InserirItempedidoState();
}

//INSERIRBOIDART
class _InserirItempedidoState extends State<InserirItempedidoPage> {
  final _formKey = GlobalKey<FormState>();
  final _idpedidoController = TextEditingController();
  final _idprodutoController = TextEditingController();
  final _quantidadeController = TextEditingController();

  @override
//DISPOSE
  void dispose() {
    _idpedidoController.dispose();
    _idprodutoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  //SALVAR - INT COM BANCO - NOVO

  //--- SALVAR ANTIGO----

  void _salvar() async {
    Itempedido itempedido = Itempedido.novo(
        int.parse(_idpedidoController.text),
        int.parse(_idprodutoController.text),
        int.parse(_quantidadeController.text));

    try {
      ItempedidoRepository repository = ItempedidoRepository();
      await repository.inserir(itempedido);
      _idpedidoController.clear();
      _idprodutoController.clear();
      _quantidadeController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item do pedido salvo com sucesso')));
    } catch (exception, s) {
      showError(context, "Erro inserindo item do pedido", exception.toString());
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
                Text('Id Pedido'),
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
                  controller: _quantidadeController, //VER AQUI
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
        title: Text("Inserir Item do pedido"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}
