/*import 'dart:html';
import 'dart:io';*/
import 'package:http/http.dart' as http;
import 'package:pedido/model/itempedido.dart';
import 'api.dart';

class ItempedidoRest {
  Future<Itempedido> buscar(int id) async {
    final http.Response response = await http
        .get(Uri.http(Api.endpoint, '/clientes/pedidos/itenspedidos/$id'));
    if (response.statusCode == 200) {
      return Itempedido.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando itempedido: ${id} [code: ${response.statusCode}]');
    }
  }

//BOI_REST.DART (3)
  Future<List<Itempedido>> buscarTodos() async {
    final http.Response response = await http
        .get(Uri.http(Api.endpoint, '/clientes/pedidos/itenspedidos'));
    if (response.statusCode == 200) {
      return Itempedido.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os pedidos');
    }
  }

  //BOI_REST.DART (4)
  Future<Itempedido> inserir(Itempedido itempedido) async {
    itempedido.id = -1;
    final http.Response response = await http.post(
        Uri.http(Api.endpoint, '/clientes/pedidos/itenspedidos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: itempedido.toJson());
    if (response.statusCode == 201) {
      return Itempedido.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo itempedido.');
    }
  }

//BOI_REST.DART (5)
  Future<Itempedido> alterar(Itempedido itempedido) async {
    final http.Response response = await http.put(
      Uri.http(Api.endpoint, '/clientes/pedidos/itenspedidos/${itempedido.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: itempedido.toJson(),
    );
    if (response.statusCode == 200) {
      return itempedido;
    } else {
      throw Exception('Erro alternando itempedido ${itempedido.id}.');
    }
  }

//BOI_REST.DART (6)
  Future<Itempedido> remover(int id) async {
    final http.Response response = await http.delete(
        Uri.http(Api.endpoint, '/clientes/pedidos/itenspedidos/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return Itempedido.fromJson(response.body);
      //return Boi(); PROFESSOR QUE FALOU PARA FAZER ISSO
    } else {
      throw Exception('Erro removido itempedido: $id.');
    }
  }
}
