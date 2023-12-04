import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/cliente.dart';
import 'package:pedido/repositories/cliente_repository.dart';
import 'editar_cliente_page.dart';

//LISTARBOIPAGE
class ListarClientesPage extends StatefulWidget {
  static const String routeName = '/list';
  @override
  State<StatefulWidget> createState() => _ListarClientesState();
}

class _ListarClientesState extends State<ListarClientesPage> {
  List<Cliente> _lista = <Cliente>[];

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
    List<Cliente> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
    });
  }

//OBTERTODOS
  Future<List<Cliente>> _obterTodos() async {
    List<Cliente> tempLista = <Cliente>[];
    try {
      ClienteRepository repository = ClienteRepository();
      tempLista = await repository.buscarTodos();
    } catch (exception) {
      showError(context, "Erro obtendo lista de bois", exception.toString());
    }

    return tempLista;
  }
/*
OBTERTODOS-SQLITE-DAOECONECTION
//Banco de dados buscar as Informações
    Database db = await ConennectionFactory.factory.database;
    BoiDAO = Boi(db);

    List<Cliente> tempLista = await dao.obterTodos();
    ConennectionFactory.factory.close();
*/
  //<Cliente>[
  //Boi(1, "nome", "raca", 10), //dar uma olhada aqui
  //];

//REMOVEBOI
  void _removerCliente(int id) async {
    try {
      ClienteRepository repository = ClienteRepository();
      await repository.remover(id);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cliente $id removido com sucesso')));
    } catch (exception) {
      showError(context, "Erro removendo boi", exception.toString());
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
    Cliente cliente = _lista[index];
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              title: Text(cliente.nome),
              content: Column(
                children: [
                  Text("Nome: ${cliente.nome}"),
                  Text("Sobrenome: ${cliente.sobrenome}"),
                  Text("CPF: ${cliente.cpf}"),
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
    Cliente c = _lista[index];
    Navigator.pushNamed(
      context,
      EditarClientePage.routeName,
      arguments: <String, int>{"id": c.id!},
    );
  }

//REMOVEITEM

  void _removeItem(BuildContext context, int index) {
    Cliente c = _lista[index];
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Remover Cliente"),
              content: Text("Gostaria realmente de remover ${c.nome}?"),
              actions: [
                TextButton(
                  child: Text("Sim"),
                  onPressed: () {
                    _removerCliente(c.id!);
                    _refreshList();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

//BUILDITEM
  ListTile _buildItem(BuildContext context, int index) {
    Cliente c = _lista[index];
    return ListTile(
      leading: const Icon(Icons.pets),
      title: Text(c.nome),
      subtitle: Text(c.cpf),
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
          title: const Text("Listagem de Clientes"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: _lista.length,
          itemBuilder: _buildItem,
        ));
  }
}
