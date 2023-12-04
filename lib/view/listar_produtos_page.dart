import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/produto.dart';
import 'package:pedido/repositories/produto_repository.dart';
import 'editar_produto_page.dart';

//LISTARBOIPAGE
class ListarProdutosPage extends StatefulWidget {
  static const String routeNameP = '/listProduto';
  @override
  State<StatefulWidget> createState() => _ListarProdutosState();
}

class _ListarProdutosState extends State<ListarProdutosPage> {
  List<Produto> _lista = <Produto>[];

//REFRESHLIST
  @override
  void initState() {
    super.initState();
    _refreshList();
  }

//DISPOSE
  @override
  void dispose() {
    super.dispose();
  }

//REFRESHLIST
  void _refreshList() async {
    List<Produto> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
    });
  }

//OBTERTODOS
  Future<List<Produto>> _obterTodos() async {
    List<Produto> tempLista = <Produto>[];
    try {
      ProdutoRepository repository = ProdutoRepository();
      tempLista = await repository.buscarTodos();
    } catch (exception) {
      showError(context, "Erro obtendo lista de produto", exception.toString());
    }

    return tempLista;
  }
/*
OBTERTODOS-SQLITE-DAOECONECTION
//Banco de dados buscar as Informações
    Database db = await ConennectionFactory.factory.database;
    BoiDAO = Boi(db);

    List<Produto> tempLista = await dao.obterTodos();
    ConennectionFactory.factory.close();
*/
  //<Produto>[
  //Boi(1, "descricao", "raca", 10), //dar uma olhada aqui
  //];

//REMOVEBOI
  void _removerProduto(int id) async {
    try {
      ProdutoRepository repository = ProdutoRepository();
      await repository.remover(id);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produto $id removido com sucesso')));
    } catch (exception) {
      showError(context, "Erro removendo produto", exception.toString());
    }
  }
//REMOVEBOI-SQLITE-DAOECONECTION
/*
Database db = await ConennectionFactory.factory.database;
    BoiDAO dao = BoiDAO(db);
    await dao.remover(id);

ConennectionFactory.factory.close();
*/

//SHOWITEM ANTIGO

  void _showItem(BuildContext context, int index) {
    Produto produto = _lista[index];
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              title: Text(produto.descricao),
              content: Column(
                children: [
                  Text("Descricao: ${produto.descricao}"),
                  //Text("Sobrenome: ${produto.sobrenome}"),
                  //Text("CPF: ${produto.cpf}"),
                ],
              ),
              actions: [
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        }));
  }

//SHOWITEM NOVO DAO
/*  void _showItem(BuildContext context, int index) {
    Boi boi = _lista[index];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(boi.descricao),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.create),
                    Text("Descricao: ${boi.descricao}")
                  ]),
                  Row(children: [
                    Icon(Icons.assistant_photo),
                    Text("Raça: ${boi.raca}")
                  ]),
                  Row(children: [
                    Icon(Icons.cake),
                    Text("Idade: ${boi.idade} anos")
                  ]),
                ],
              ),
              actions: [
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
*/
//EDITITEM
  void _editItem(BuildContext context, int index) {
    Produto c = _lista[index];
    Navigator.pushNamed(
      context,
      EditarProdutoPage.routeNameP,
      arguments: <String, int>{"id": c.id!},
    );
  }

//REMOVEITEM

  void _removeItem(BuildContext context, int index) {
    Produto c = _lista[index];
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Remover Produto"),
              content: Text("Gostaria realmente de remover ${c.descricao}?"),
              actions: [
                TextButton(
                  child: Text("Sim"),
                  onPressed: () {
                    _removerProduto(c.id!);
                    _refreshList();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

//BUILDITEM
  ListTile _buildItem(BuildContext context, int index) {
    Produto c = _lista[index];
    return ListTile(
      leading: const Icon(Icons.pets),
      title: Text(c.descricao),
      //subtitle: Text(c.cpf),
      onTap: () {
        _showItem(context, index);
      },
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            const PopupMenuItem(value: 'edit', child: Text('Editar')),
            const PopupMenuItem(value: 'delete', child: Text('Remover')),
          ];
        },
        onSelected: (String value) {
          if (value == 'edit')
            _editItem(context, index);
          else
            _removeItem(context, index);
        },
      ),
    );
  }

//BUILD

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Listagem de Produtos"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: _lista.length,
          itemBuilder: _buildItem,
        ));
  }
}
