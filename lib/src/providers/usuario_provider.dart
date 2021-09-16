import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mr_shop/src/api/environment.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:mr_shop/utils/my_snackbar.dart';

/* Para usar el basename en el método createWithImage
  se debe utilizar este paquete */

import 'package:path/path.dart';

class UsuarioProvider{
  String _api = Environment.API_MR_SHOP;
  String _url = '/api/usuarios';
  BuildContext context;

  Future init(BuildContext context){
    this.context = context;
  }

  Future<Stream> createWithImage(Usuario usuario,File imagen)async{
    try{
     /* print('imagen: $imagen');
      print('usuario: $usuario');
      return null;*/
      Uri url = Uri.http(_api, '$_url/create');
      final request = http.MultipartRequest('POST',url);
      if(imagen != null){
        request.files.add(http.MultipartFile(
          'imagen',
          http.ByteStream(imagen.openRead().cast()),
          await imagen.length(),
          filename: basename(imagen.path)
        ));
      }

      request.fields['usuario'] = json.encode(usuario);
      /*Enviar la petición a nodejs*/
      final response = await request.send();
      return response.stream.transform(utf8.decoder);


    }catch(err){
      print('Error al registrar la imagen:$err');
      return null;
    }
  }


  Future<ResponseApi>create(Usuario usuario)async{

    try{
      Uri url = Uri.http(_api, '$_url/create');
      String bodyParams = json.encode(usuario);
      Map<String,String>headers ={
        'Content-type':'application/json'
      };
      final res = await http.post(url,headers: headers,body: bodyParams);
      final data = json.decode(res.body);
      print("data user provider: $data ");
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;

    }catch(error){
      print('Error usuario provider : $error');
      MySnackBar.show(context, 'Error no se ha podido conectar con el servidor');
      return null;
    }

  }

  Future<ResponseApi>login(email,password)async{

    try{
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({
        'email': email,
        'password':password
      });
      Map<String,String>headers ={
        'Content-type':'application/json'
      };
      final res = await http.post(url,headers: headers,body: bodyParams);
      final data = json.decode(res.body);
      print("data user provider: $data ");
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;

    }catch(error){
      print('Error usuario provider : $error');
      return null;
    }

  }



}