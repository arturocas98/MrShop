// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

import 'package:mr_shop/src/models/rol.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  String id;
  String nombre;
  String apellido;
  String email;
  String telefono;
  String password;
  String imagen;
  String token;
  List<Rol> roles =[];
  Usuario({
    this.id,
    this.nombre,
    this.apellido,
    this.email,
    this.telefono,
    this.password,
    this.imagen,
    this.token,
    this.roles
  });



  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"] is int ? json['id'].toString():json["id"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    email: json["email"],
    telefono: json["telefono"],
    password: json["password"],
    imagen: json["imagen"],
    token: json["token"],
    roles: json["roles"] == null ? []: List<Rol>.from(json['roles'].map( 
      (model)=> Rol.fromJson(model)
    ))?? [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "apellido": apellido,
    "email": email,
    "telefono": telefono,
    "password": password,
    "imagen": imagen,
    "token":token,
    "roles":roles
  };
}
