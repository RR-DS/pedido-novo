import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/pedido.dart';
import 'package:pedido/repositories/pedido_repository.dart';
import 'editar_pedido_page.dart';

//LISTARBOIPAGE
class ListarPedidosPage extends StatefulWidget {
  static const String routeNamePdd = '/listPedido';
  @override
  State<StatefulWidget> createState() => _ListarPedidosState();
}

class _ListarPedidosState extends State<ListarPedidosPage> {
  List<Pedido> _lista = <Pedido>[];

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
    List<Pedido> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
    });
  }

//OBTERTODOS
  Future<List<Pedido>> _obterTodos() async {
    List<Pedido> tempLista = <Pedido>[];
    try {
      PedidoRepository repository = PedidoRepository();
      tempLista = await repository.buscarTodos();
    } catch (exception) {
      showError(context, "Erro obtendo lista de pedido", exception.toString());
    }

    return tempLista;
  }
/*
OBTERTODOS-SQLITE-DAOECONECTION
//Banco de dados buscar as Informações
    Database db = await ConennectionFactory.factory.database;
    BoiDAO = Boi(db);

    List<Pedido> tempLista = await dao.obterTodos();
    ConennectionFactory.factory.close();
*/
  //<Pedido>[
  //Boi(1, "nome", "raca", 10), //dar uma olhada aqui
  //];

//REMOVEBOI
  void _removerPedido(int id) async {
    try {
      PedidoRepository repository = PedidoRepository();
      await repository.remover(id);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pedido $id removido com sucesso')));
    } catch (exception) {
      showError(context, "Erro removendo pedido", exception.toString());
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
    Pedido pedido = _lista[index];
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              title: Text(pedido.data),
              content: Column(
                children: [
                  Text("Data: ${pedido.data}"),
                  Text("Id Produto: ${pedido.idproduto}"),
                  Text("Quantidade: ${pedido.quantidade}"),
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
              title: Text(boi.nome),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.create),
                    Text("Nome: ${boi.nome}")
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
    Pedido c = _lista[index];
    Navigator.pushNamed(
      context,
      EditarPedidoPage.routeNamePdd,
      arguments: <String, int>{"id": c.id!},
    );
  }

//REMOVEITEM

  void _removeItem(BuildContext context, int index) {
    Pedido c = _lista[index];
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Remover Pedido"),
              content: Text("Gostaria realmente de remover ${c.id}?"),
              actions: [
                TextButton(
                  child: Text("Sim"),
                  onPressed: () {
                    _removerPedido(c.id!);
                    _refreshList();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

//BUILDITEM
  ListTile _buildItem(BuildContext context, int index) {
    Pedido c = _lista[index];
    return ListTile(
      leading: const Icon(Icons.pets),
      title: Text(c.data), //(c.nome)
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
          title: const Text("Listagem de Pedidos"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: _lista.length,
          itemBuilder: _buildItem,
        ));
  }
}
