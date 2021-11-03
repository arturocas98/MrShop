import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mr_shop/src/api/environment.dart';
import 'package:mr_shop/src/models/producto.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/utils/my_snackbar.dart';
import 'package:path/path.dart';

class ProductoProvider{
  BuildContext context;
  String _api = Environment.API_MR_SHOP;
  String _url = '/api/producto';
  Usuario sessionUser;
  Future init(BuildContext context,{Usuario sessionUser}){
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List <Producto>> getByCategoria(String categoria_id)async{
    try{

      Uri url = Uri.http(_api,'$_url/getByCategoria/$categoria_id');
      Map<String,String> headers ={
        'Content-type':'application/json',
        'Authorization':sessionUser.token
      };
      final res = await http.get(url,headers:headers);
      final data = json.decode(res.body);
      Producto producto = Producto.fromJsonList(data);
      return producto.toList;


    }catch(err){
      print("Error al obtener las productos $err");
      MySnackBar.show(context, 'Error al obtener las productos $err');
    }
  }

  Future<Stream> create(Producto producto,List<File> imagenes)async{
    try{

      Uri url = Uri.http(_api, '$_url/create');
      final request = http.MultipartRequest('POST',url);
      request.headers['Authorization'] = sessionUser.token;
      /*Recorremos todas las imagenes y las guardamos en el campo
      * imagen del response*/

      for(int i = 0 ; i<imagenes.length;i++){
        request.files.add(http.MultipartFile(
            'imagen',
            http.ByteStream(imagenes[i].openRead().cast()),
            await imagenes[i].length(),
            filename: basename(imagenes[i].path)
        ));

      }

      request.fields['producto'] = json.encode(producto);

      /*Enviar la petición a nodejs*/
      final response = await request.send();
      return response.stream.transform(utf8.decoder);


    }catch(err){
      print('Error al crear el producto:$err');
      return null;
    }
  }

}