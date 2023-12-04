/*import 'dart:html';
import 'dart:io';*/
import 'package:http/http.dart' as http;
import 'package:pedido/model/cliente.dart';
import 'api.dart';

class ClienteRest {
  Future<Cliente> buscar(int id) async {
    final http.Response response =
        await http.get(Uri.http(Api.endpoint, '/clientes/$id'));
    if (response.statusCode == 200) {
      return Cliente.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando boi: ${id} [code: ${response.statusCode}]');
    }
  }

//BOI_REST.DART (3)
  Future<List<Cliente>> buscarTodos() async {
    final http.Response response =
        await http.get(Uri.http(Api.endpoint, 'clientes'));
    if (response.statusCode == 200) {
      return Cliente.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os clientes');
    }
  }

  //BOI_REST.DART (4)
  Future<Cliente> inserir(Cliente cliente) async {
    final http.Response response =
        await http.post(Uri.http(Api.endpoint, 'clientes'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: cliente.toJson());
    if (response.statusCode == 201) {
      return Cliente.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo cliente.');
    }
  }

//BOI_REST.DART (5)
  Future<Cliente> alterar(Cliente cliente) async {
    final http.Response response = await http.put(
      Uri.http(Api.endpoint, 'clientes/${cliente.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: cliente.toJson(),
    );
    if (response.statusCode == 200) {
      return cliente;
    } else {
      throw Exception('Erro alternando cliente ${cliente.id}.');
    }
  }

//BOI_REST.DART (6)
  Future<Cliente> remover(int id) async {
    final http.Response response = await http.delete(
        Uri.http(Api.endpoint, '/clientes/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return Cliente.fromJson(response.body);
      //return Boi(); PROFESSOR QUE FALOU PARA FAZER ISSO
    } else {
      throw Exception('Erro removido boi: $id.');
    }
  }
}
