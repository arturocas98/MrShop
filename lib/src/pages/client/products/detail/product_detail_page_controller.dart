import 'package:flutter/material.dart';
import 'package:mr_shop/src/models/producto.dart';

class ProductDetailPageController{
  BuildContext context;
  Function refresh;
  Producto producto;


  Future init(BuildContext context,Function refresh,Producto producto){
    this.context = context;
    this.refresh = refresh;
    this.producto = producto;
    refresh();
  }



}