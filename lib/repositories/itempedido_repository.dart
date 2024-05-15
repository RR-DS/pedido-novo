import 'dart:async';
import 'package:pedido/model/itempedido.dart';
import 'package:pedido/rest/itempedido_rest.dart';

class ItempedidoRepository {
  final ItempedidoRest api = ItempedidoRest();
  Future<Itempedido> buscar(int id) async {
    return await api.buscar(id);
  }

  Future<List<Itempedido>> buscarTodos() async {
    return await api.buscarTodos();
  }

  Future<Itempedido> inserir(Itempedido itempedido) async {
    return await api.inserir(itempedido);
  }

  Future<Itempedido> alterar(Itempedido itempedido) async {
    return await api.alterar(itempedido);
  }

  Future<Itempedido> remover(int id) async {
    return await api.remover(id);
  }
}
