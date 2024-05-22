import 'package:flutter/material.dart';
import 'package:pedido/view/editar_pedido_page.dart';
import 'package:pedido/view/editar_produto_page.dart';
import 'package:pedido/view/inserir_pedido_page.dart';
import 'package:pedido/view/inserir_produto_page.dart';
import 'package:pedido/view/listar_pedidos_page.dart';
import 'package:pedido/view/listar_produtos_page.dart';

import 'routes/routes.dart';
import 'view/editar_cliente_page.dart';
import 'view/inserir_cliente_page.dart';
import 'view/listar_clientes_page.dart';
import 'view/editar_itempedido_page.dart';
import 'view/inserir_itempedido_page.dart';
import 'view/listar_itempedidos_page.dart';

//MAIN.DART
void main() {
  runApp(const MyApp());
}

//MYAPP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedido System',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
          primarySwatch: Colors.yellow),
      home: MyHomePage(title: 'Pedido System'),
      routes: {
        Routes.edit: (context) => EditarClientePage(),
        Routes.insert: (context) => InserirClientePage(),
        Routes.list: (context) => ListarClientesPage(),
        Routes.editProduto: (context) => EditarProdutoPage(),
        Routes.insertProduto: (context) => InserirProdutoPage(),
        Routes.listProduto: (context) => ListarProdutosPage(),
        Routes.editPedido: (context) => EditarPedidoPage(),
        Routes.insertPedido: (context) => InserirPedidoPage(),
        Routes.listPedido: (context) => ListarPedidosPage(),
        Routes.editItem: (context) => EditarItempedidoPage(),
        Routes.insertItem: (context) => InserirItempedidoPage(),
        Routes.listItem: (context) => ListarItempedidosPage(),
      },
    );
  }
}

//MYHOMEPAGE
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

//MYHOMEPAGESTATE
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: AppDrawer(),
    );
  }
}

//DRAWER
//APPDRAWER
class AppDrawer extends StatelessWidget {
//BUILD
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.add,
              text: 'Inserir Cliente',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.insert)),
//Divider(),
          _createDrawerItem(
              icon: Icons.list,
              text: 'Listar Clientes',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.list)),
          Divider(),
          //ListTile(title: Text('0.0.1'), onTap: () {}),
          _createDrawerItem(
              icon: Icons.add,
              text: 'Inserir Produto',
              onTap: () => Navigator.pushReplacementNamed(
                  context, Routes.insertProduto)),
//Divider(),
          _createDrawerItem(
              icon: Icons.list,
              text: 'Listar Produtos',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.listProduto)),
          Divider(),
          // ListTile(title: Text('0.0.1'), onTap: () {}),
          _createDrawerItem(
              icon: Icons.add,
              text: 'Inserir Pedido',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.insertPedido)),
//Divider(),
          _createDrawerItem(
              icon: Icons.list,
              text: 'Listar Pedido',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.listPedido)),
          Divider(),
          // ListTile(title: Text('0.0.1'), onTap: () {}),
          _createDrawerItem(
              icon: Icons.add,
              text: 'Inserir Item do Pedido',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.insertItem)),
//Divider(),
          _createDrawerItem(
              icon: Icons.list,
              text: 'Listar Item do Pedido',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.listItem)),
          Divider(),
          // ListTile(title: Text('0.0.1'), onTap: () {}),
        ],
      ),
    );
  }
}

//CREATEHEADER
Widget _createHeader() {
  return const DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('pacote da Imagem.png'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Cadastro de Pedidos",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

//CREATEDRAWERITEM

Widget _createDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(children: <Widget>[
      Icon(icon),
      Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Text(text),
      )
    ]),
    onTap: onTap,
  );
}
