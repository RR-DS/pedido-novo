import 'dart:convert';
//import 'package:flutter/rendering.dart';

class Itempedido {
  int? id;
  int idpedido;
  int idproduto;
  int qtdade;
  //int idade;

  Itempedido(this.id, this.idpedido, this.idproduto, this.qtdade);
  Itempedido.novo(this.idpedido, this.idproduto, this.qtdade);

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'idpedido': this.idpedido,
      'idproduto': this.idproduto,
      'qtdade': this.qtdade,
      //'boi_idade': this.idade
    };
  }

  static Itempedido fromMap(Map<String, dynamic> map) {
    return Itempedido(
      map['id'],
      map['idpedido'],
      map['idproduto'],
      map['qtdade'],
    ); //id, data, qtdade)
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
