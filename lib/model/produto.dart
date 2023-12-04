import 'dart:convert';
//import 'package:flutter/rendering.dart';

class Produto {
  int? id;
  String descricao;
  //String sobrenome;
  // String cpf;
  //int idade;

  Produto(this.id, this.descricao);
  Produto.novo(this.descricao);

  Map<String, dynamic> toMap() {
    return {
      'produto_id': this.id,
      'produto_descricao': this.descricao,
      //'produto_sobrenome': this.sobrenome,
      //'produto_cpf': this.cpf,
      //'produto_idade': this.idade
    };
  }

  static Produto fromMap(Map<String, dynamic> map) {
    return Produto(
      map['produto_id'],
      map['produto_descricao'],
      //map['produto_sobrenome'],
      // map['produto_cpf'],
    ); //id, descricao, cpf)
  }

  static List<Produto> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Produto.fromMap(maps[i]);
    });
  }

  static Produto fromJson(String j) => Produto.fromMap(jsonDecode(j));
  static List<Produto> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Produto>((map) => Produto.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
