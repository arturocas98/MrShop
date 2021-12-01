import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mr_shop/src/models/producto.dart';
import 'package:mr_shop/utils/shared_preference.dart';

class CreateOrderPageController{
  BuildContext context;
  Function refresh;


  SharedPreference _sharedPreference = new SharedPreference();
  List<Producto> productoSeleccionado = [];

  Future init(BuildContext context,Function refresh,Producto producto)async{
    this.context = context;
    this.refresh = refresh;
    productoSeleccionado = Producto.fromJsonList( await _sharedPreference.read('orden')).toList;

    refresh();
  }
}