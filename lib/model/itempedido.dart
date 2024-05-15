import 'dart:convert';
//import 'package:flutter/rendering.dart';

class Itempedido {
  int? id;
  String idpedido;
  String idproduto;
  String quantidade;
  //int idade;

  Itempedido(this.id, this.idpedido, this.idproduto, this.quantidade);
  Itempedido.novo(this.idpedido, this.idproduto, this.quantidade);

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'idpedido': this.idpedido,
      'idproduto': this.idproduto,
      'quantidade': this.quantidade,
      //'boi_idade': this.idade
    };
  }

  static Itempedido fromMap(Map<String, dynamic> map) {
    return Itempedido(
      map['id'],
      map['idpedido'],
      map['idproduto'],
      map['quantidade'],
    ); //id, data, quantidade)
  }

  static List<Itempedido> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Itempedido.fromMap(maps[i]);
    });
  }

  static Itempedido fromJson(String j) => Itempedido.fromMap(jsonDecode(j));
  static List<Itempedido> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Itempedido>((map) => Itempedido.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
