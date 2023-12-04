/*import 'dart:html';
import 'dart:io';*/
import 'package:http/http.dart' as http;
import 'package:pedido/model/produto.dart';
import 'api.dart';

class ProdutoRest {
  Future<Produto> buscar(int id) async {
    final http.Response response =
        await http.get(Uri.http(Api.endpoint, '/produtos/$id'));
    if (response.statusCode == 200) {
      return Produto.fromJson(response.body);
    } else {
      throw Exception(
          'Erro buscando produto: ${id} [code: ${response.statusCode}]');
    }
  }

//BOI_REST.DART (3)
  Future<List<Produto>> buscarTodos() async {
    final http.Response response =
        await http.get(Uri.http(Api.endpoint, 'produtos'));
    if (response.statusCode == 200) {
      return Produto.fromJsonList(response.body);
    } else {
      throw Exception('Erro buscando todos os produtos');
    }
  }

  //BOI_REST.DART (4)
  Future<Produto> inserir(Produto produto) async {
    final http.Response response =
        await http.post(Uri.http(Api.endpoint, 'produtos'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: produto.toJson());
    if (response.statusCode == 201) {
      return Produto.fromJson(response.body);
    } else {
      throw Exception('Erro inserindo produto.');
    }
  }

//BOI_REST.DART (5)
  Future<Produto> alterar(Produto produto) async {
    final http.Response response = await http.put(
      Uri.http(Api.endpoint, 'produtos/${produto.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: produto.toJson(),
    );
    if (response.statusCode == 200) {
      return produto;
    } else {
      throw Exception('Erro alternando produto ${produto.id}.');
    }
  }

//BOI_REST.DART (6)
  Future<Produto> remover(int id) async {
    final http.Response response = await http.delete(
        Uri.http(Api.endpoint, '/produtos/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return Produto.fromJson(response.body);
      //return Boi(); PROFESSOR QUE FALOU PARA FAZER ISSO
    } else {
      throw Exception('Erro removido produto: $id.');
    }
  }
}
