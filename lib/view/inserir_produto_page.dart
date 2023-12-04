import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/produto.dart';
import 'package:pedido/repositories/produto_repository.dart';

class InserirProdutoPage extends StatefulWidget {
  static const String routeNameP = '/insertProduto';

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
  /* void _salvar() async {
    _descricaoController.clear();
    _racaController.clear();
    _idadeController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Boi salvo com sucesso')));
  }
*/
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
    } catch (exception) {
      showError(context, "Erro inserindo produto", exception.toString());
    }
  }

//SALVAR NOVO
/*
  void _salvar() async {
    Database db = await ConennectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);
    Boi boi = Produto.novo(_descricaoController.text, _racaController.text,
        int.parse(_idadeController.text));
    await dao.inserir(boi);
    ConennectionFactory.factory.close();
    _descricaoController.clear();
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
            /*Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Sobredescricao'),
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
            Row(
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
        title: Text("Inserir Produto"),
      ),
      drawer: AppDrawer(),
      body: _buildForm(context),
    );
  }
}
