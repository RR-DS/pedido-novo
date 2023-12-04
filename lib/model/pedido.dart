import 'dart:convert';
//import 'package:flutter/rendering.dart';

class Pedido {
  int? id;
  String data;
  String idproduto;
  String quantidade;
  //int idade;

  Pedido(this.id, this.data, this.quantidade, this.idproduto);
  Pedido.novo(this.data, this.quantidade, this.idproduto);

  Map<String, dynamic> toMap() {
    return {
      'pedido_id': this.id,
      'pedido_data': this.data,
      'pedido_idproduto': this.idproduto,
      'pedido_quantidade': this.quantidade,
      //'boi_idade': this.idade
    };
  }

  static Pedido fromMap(Map<String, dynamic> map) {
    return Pedido(
      map['boi_id'],
      map['boi_data'],
      map['boi_idproduto'],
      map['boi_quantidade'],
    ); //id, data, quantidade)
  }

  static List<Pedido> fromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Pedido.fromMap(maps[i]);
    });
  }

  static Pedido fromJson(String j) => Pedido.fromMap(jsonDecode(j));
  static List<Pedido> fromJsonList(String j) {
    final parsed = jsonDecode(j).cast<Map<String, dynamic>>();
    return parsed.map<Pedido>((map) => Pedido.fromMap(map)).toList();
  }

  String toJson() => jsonEncode(toMap());
}
