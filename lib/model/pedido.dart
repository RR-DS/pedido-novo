import 'dart:convert';
//import 'package:flutter/rendering.dart';

class Pedido {
  int? id;
  String data;
  String idcliente;
  //String quantidade;
  //int idade;

  Pedido(this.id, this.data, this.idcliente);
  Pedido.novo(this.data, this.idcliente);

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'data': this.data,
      'idcliente': this.idcliente,
      //'pedido_quantidade': this.quantidade,
      //'boi_idade': this.idade
    };
  }

  static Pedido fromMap(Map<String, dynamic> map) {
    return Pedido(
      map['id'],
      map['data'],
      map['idcliente'],
      //map['boi_quantidade'],
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
