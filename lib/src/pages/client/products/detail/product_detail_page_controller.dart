import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mr_shop/src/models/producto.dart';
import 'package:mr_shop/utils/shared_preference.dart';

class ProductDetailPageController{
  BuildContext context;
  Function refresh;
  Producto producto;
  double precioProducto;
  int cantidad = 1;

  SharedPreference _sharedPreference = new SharedPreference();
  List<Producto> productoSeleccionado = [];

  Future init(BuildContext context,Function refresh,Producto producto)async{
    this.context = context;
    this.refresh = refresh;
    this.producto = producto;
    precioProducto = producto.precio;

    productoSeleccionado = Producto.fromJsonList( await _sharedPreference.read('orden')).toList;

    productoSeleccionado.forEach((element) {
      print('producto: ${element.toJson()}');
    });



    refresh();
  }

  void anadirCarrito()async{
    int index= productoSeleccionado.indexWhere((p) =>p.id == producto.id );
    /*Si el producto aun no ha sido agregado*/
    if(index == -1){
      if(producto.cantidad == null){
        producto.cantidad = 1;
      }
      
      productoSeleccionado.add(producto);
    }else{
      productoSeleccionado[index].cantidad += cantidad;
    }

    await _sharedPreference.save('orden', productoSeleccionado);
    Fluttertoast.showToast(msg: 'Producto agregado');
    Navigator.pop(context);

  }


  void addProducto(){
    cantidad = cantidad + 1;
    precioProducto = producto.precio * cantidad;
    producto.cantidad = cantidad;
    refresh();
  }

  void removeProducto(){
    if(cantidad > 1){
      cantidad = cantidad - 1;
      precioProducto = producto.precio * cantidad;
      producto.cantidad = cantidad;
      refresh();
    }
  }

  void closeModal(){
    Navigator.pop(context);
  }


}