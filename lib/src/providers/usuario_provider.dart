import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mr_shop/src/api/environment.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider{
  String _url = Environment.API_MR_SHOP;
  String _api = '/api/usuarios';
  BuildContext context;

  Future init(BuildContext context){
    this.context = context;
  }

  Future<ResponseApi>create(Usuario usuario)async{

    try{
      Uri url = Uri.http(_url, '$_api/create');
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