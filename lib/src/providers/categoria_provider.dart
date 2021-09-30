import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mr_shop/src/api/environment.dart';
import 'package:mr_shop/src/models/categoria.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/utils/my_snackbar.dart';
class CategoriaProvider{
  BuildContext context;
  String _api = Environment.API_MR_SHOP;
  String _url = '/api/categoria';
  Usuario sessionUser;
  Future init(BuildContext context,{Usuario sessionUser}){
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<ResponseApi> create(Categoria categoria)async{
    try{
      print("token: ${sessionUser.token}");
      Uri url = Uri.http(_api,'$_url/create');
      String bodyParams = json.encode(categoria);
      Map<String,String> headers ={
        'Content-type':'application/json',
        'Authorization':sessionUser.token
      };
      final res = await http.post(url,headers:headers,body:bodyParams);
      print("respuesta: ${res}");
      final data = json.decode(res.body);
      print("data: ${data}");
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;

    }catch(err){
      MySnackBar.show(context, 'Error al obtener las categorias $err');
    }
  }

}