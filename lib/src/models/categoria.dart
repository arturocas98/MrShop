// To parse this JSON data, do
//
//     final categoria = categoriaFromJson(jsonString);

import 'dart:convert';

import 'package:mr_shop/src/models/rol.dart';

Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria {
  String id;
  String nombre;
  String descripcion;

  Categoria({
    this.id,
    this.nombre,
    this.descripcion,

  });



  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
      id: json["id"] is int ? json['id'].toString():json["id"],
      nombre: json["nombre"],
      descripcion:json["descripcion"]

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "descripcion":descripcion
  };
}
