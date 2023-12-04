/*import 'dart:html';
import 'dart:io';*/
import 'package:http/http.dart' as http;
import 'package:pedido/model/pedido.dart';
import 'api.dart';

class PedidoRest {
  Future<Pedido> buscar(int id) async {
    final http.Response response =
        await http.get(Uri.http(Api.endpoint, '/pedidos/$id'));
    if (response.statusCode == 200) {
      return Pedido.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando pedido: ${id} [code: ${response.statusCode}]');
    }
  }

//BOI_REST.DART (3)
  Future<List<Pedido>> buscarTodos() async {
    final http.Response response =
        await http.get(Uri.http(Api.endpoint, 'pedidos'));
    if (response.statusCode == 200) {
      return Pedido.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os pedidos');
    }
  }

  //BOI_REST.DART (4)
  Future<Pedido> inserir(Pedido pedido) async {
    final http.Response response =
        await http.post(Uri.http(Api.endpoint, 'pedidos'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: pedido.toJson());
    if (response.statusCode == 201) {
      return Pedido.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo pedido.');
    }
  }

//BOI_REST.DART (5)
  Future<Pedido> alterar(Pedido pedido) async {
    final http.Response response = await http.put(
      Uri.http(Api.endpoint, 'pedidos/${pedido.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: pedido.toJson(),
    );
    if (response.statusCode == 200) {
      return pedido;
    } else {
      throw Exception('Erro alternando pedido ${pedido.id}.');
    }
  }

//BOI_REST.DART (6)
  Future<Pedido> remover(int id) async {
    final http.Response response = await http.delete(
        Uri.http(Api.endpoint, '/pedidos/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return Pedido.fromJson(response.body);
      //return Boi(); PROFESSOR QUE FALOU PARA FAZER ISSO
    } else {
      throw Exception('Erro removido pedido: $id.');
    }
  }
}
