// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

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

  Usuario({
    this.id,
    this.nombre,
    this.apellido,
    this.email,
    this.telefono,
    this.password,
    this.imagen,
  });



  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    email: json["email"],
    telefono: json["telefono"],
    password: json["password"],
    imagen: json["imagen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "apellido": apellido,
    "email": email,
    "telefono": telefono,
    "password": password,
    "imagen": imagen,
  };
}
