import 'package:pedido/view/editar_cliente_page.dart';
import 'package:pedido/view/editar_pedido_page.dart';
import 'package:pedido/view/editar_produto_page.dart';
import 'package:pedido/view/editar_itempedido_page.dart';
import 'package:pedido/view/inserir_cliente_page.dart';
import 'package:pedido/view/inserir_pedido_page.dart';
import 'package:pedido/view/inserir_produto_page.dart';
import 'package:pedido/view/inserir_itempedido_page.dart';
import 'package:pedido/view/listar_clientes_page.dart';
import 'package:pedido/view/listar_pedidos_page.dart';
import 'package:pedido/view/listar_produtos_page.dart';
import 'package:pedido/view/listar_itempedidos_page.dart';

class Routes {
  static const String list = ListarClientesPage.routeName;
  static const String insert = InserirClientePage.routeName;
  static const String edit = EditarClientePage.routeName;
  static const String listProduto = ListarProdutosPage.routeNameProduto;
  static const String insertProduto = InserirProdutoPage.routeNameProduto;
  static const String editProduto = EditarProdutoPage.routeNameProduto;
  static const String listPedido = ListarPedidosPage.routeNamePedido;
  static const String insertPedido = InserirPedidoPage.routeNamePedido;
  static const String editPedido = EditarPedidoPage.routeNamePedido;
  static const String listItem = ListarItempedidosPage.routeNameItem;
  static const String insertItem = InserirItempedidoPage.routeNameItem;
  static const String editItem = EditarItempedidoPage.routeNameItem;
}
