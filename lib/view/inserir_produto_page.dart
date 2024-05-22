import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/produto.dart';
import 'package:pedido/repositories/produto_repository.dart';

class InserirProdutoPage extends StatefulWidget {
  static const String routeNameProduto = '/insertProduto';

  @override
  _InserirProdutoState createState() => _InserirProdutoState();
}

//INSERIRBOIDART
class _InserirProdutoState extends State<InserirProdutoPage> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  //final _sobrenomeController = TextEditingController();
  //final _cpfController = TextEditingController();

  @override
//DISPOSE
  void dispose() {
    _descricaoController.dispose();
    // _sobrenomeController.dispose();
    //_cpfController.dispose();
    super.dispose();
  }

//SALVAR - INT COM BANCO - ANTIGO

  //SALVAR - INT COM BANCO - NOVO

  //--- SALVAR ANTIGO----

  void _salvar() async {
    Produto produto = Produto.novo(_descricaoController.text);

    try {
      ProdutoRepository repository = ProdutoRepository();
      await repository.inserir(produto);
      _descricaoController.clear();
      //_sobrenomeController.clear();
      //_cpfController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Produto salvo com sucesso')));
    } catch (exception, s) {
      showError(context, "Erro inserindo produto", exception.toString());
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
                Text('Descrição'),
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
        title: Text("Inserir Produto"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}
