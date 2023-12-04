import 'package:pedido/view/editar_cliente_page.dart';
import 'package:pedido/view/editar_pedido_page.dart';
import 'package:pedido/view/editar_produto_page.dart';
import 'package:pedido/view/inserir_cliente_page.dart';
import 'package:pedido/view/inserir_pedido_page.dart';
import 'package:pedido/view/inserir_produto_page.dart';
import 'package:pedido/view/listar_clientes_page.dart';
import 'package:pedido/view/listar_pedidos_page.dart';
import 'package:pedido/view/listar_produtos_page.dart';

class Routes {
  static const String list = ListarClientesPage.routeName;
  static const String insert = InserirClientePage.routeName;
  static const String edit = EditarClientePage.routeName;
  static const String listProduto = ListarProdutosPage.routeNameP;
  static const String insertProduto = InserirProdutoPage.routeNameP;
  static const String editProduto = EditarProdutoPage.routeNameP;
  static const String listPdd = ListarPedidosPage.routeNamePdd;
  static const String insertPdd = InserirPedidoPage.routeNamePdd;
  static const String editPdd = EditarPedidoPage.routeNamePdd;
}
