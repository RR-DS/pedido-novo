import 'dart:convert';
//import 'package:flutter/rendering.dart';

class Cliente {
  int? id;
  String nome;
  String sobrenome;
  String cpf;
  //int idade;

  Cliente(this.id, this.nome, this.cpf, this.sobrenome);
  Cliente.novo(this.nome, this.cpf, this.sobrenome);

  Map<String, dynamic> toMap() {
    return {
      'cliente_id': this.id,
      'cliente_nome': this.nome,
      'cliente_sobrenome': this.sobrenome,
      'cliente_cpf': this.cpf,
      //'boi_idade': this.idade
    };
  }

  static Cliente fromMap(Map<String, dynamic> map) {
    return Cliente(
      map['boi_id'],
      map['boi_nome'],
      map['boi_sobrenome'],
      map['boi_cpf'],
    ); //id, nome, cpf)
  }

  static List<Cliente> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Cliente.fromMap(maps[i]);
    });
  }

  static Cliente fromJson(String j) => Cliente.fromMap(jsonDecode(j));
  static List<Cliente> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Cliente>((map) => Cliente.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
