import 'package:flutter/material.dart';
import 'package:pedido/helper/error.dart';
import 'package:pedido/main.dart';
import 'package:pedido/model/itempedido.dart';
import 'package:pedido/repositories/itempedido_repository.dart';
import 'editar_itempedido_page.dart';

//LISTARBOIPAGE
class ListarItempedidosPage extends StatefulWidget {
  static const String routeNameItempdd = '/listItempdd';
  @override
  State<StatefulWidget> createState() => _ListarItempedidosState();
}

class _ListarItempedidosState extends State<ListarItempedidosPage> {
  List<Itempedido> _lista = <Itempedido>[];

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
    List<Itempedido> tempList = await _obterTodos();
    setState(() {
      _lista = tempList;
    });
  }

//OBTERTODOS
  Future<List<Itempedido>> _obterTodos() async {
    List<Itempedido> tempLista = <Itempedido>[];
    try {
      ItempedidoRepository repository = ItempedidoRepository();
      tempLista = await repository.buscarTodos();
    } catch (exception) {
      showError(
          context, "Erro obtendo lista de itempedido", exception.toString());
    }

    return tempLista;
  }

//REMOVE
  void _removerItempedido(int id) async {
    try {
      ItempedidoRepository repository = ItempedidoRepository();
      await repository.remover(id);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Itempedido $id removido com sucesso')));
    } catch (exception) {
      showError(context, "Erro removendo itempedido", exception.toString());
    }
  }

//SHOWITEM

  void _showItem(BuildContext context, int index) {
    Itempedido itempedido = _lista[index];
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              title: Text(itempedido.idpedido.toString()),
              content: Column(
                children: [
                  Text("Id Pedido : ${itempedido.idpedido}"),
                  Text("Id Produto: ${itempedido.idproduto}"),
                  Text("Quantidade: ${itempedido.qtdade}"),
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

//EDITITEM
  void _editItem(BuildContext context, int index) {
    Itempedido c = _lista[index];
    Navigator.pushNamed(
      context,
      EditarItempedidoPage.routeNameItempdd,
      arguments: <String, int>{"id": c.id!},
    );
  }

//REMOVEITEM

  void _removeItem(BuildContext context, int index) {
    Itempedido c = _lista[index];
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Remover Item do pedido"),
              content: Text("Gostaria realmente de remover ${c.id}?"),
              actions: [
                TextButton(
                  child: Text("Sim"),
                  onPressed: () {
                    _removerItempedido(c.id!);
                    _refreshList();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

//BUILDITEM
  ListTile _buildItem(BuildContext context, int index) {
    Itempedido c = _lista[index];
    return ListTile(
      leading: const Icon(Icons.pets),
      title: Text(c.id.toString()), //Text(c.idproduto),
      //subtitle: Text(c.qtdade.toString()),
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
          title: const Text("Listagem de Item de Pedidos"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: _lista.length,
          itemBuilder: _buildItem,
        ));
  }
}
