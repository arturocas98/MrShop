import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_shop/src/models/categoria.dart';
import 'package:mr_shop/src/models/producto.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/src/providers/categoria_provider.dart';
import 'package:mr_shop/src/providers/producto_provider.dart';
import 'package:mr_shop/utils/my_snackbar.dart';
import 'package:mr_shop/utils/shared_preference.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class StoreProductsCreateController {
  BuildContext context;
  Function refresh;
  CategoriaProvider _categoriaProvider = new CategoriaProvider();
  TextEditingController nombreController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();
  MoneyMaskedTextController priceController = new MoneyMaskedTextController();
  ProgressDialog _progressDialog;
  bool is_enable = true;
  Usuario usuario;
  SharedPreference _sharedPreference = new SharedPreference();
  List<Categoria> categorias = [];
  String idCategoria;
  PickedFile pickedFile;
  File imageFile1;
  File imageFile2;
  File imageFile3;
  ProductoProvider _productoProvider = new ProductoProvider();

  Future init(BuildContext context,Function refresh)async{
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context:context);
    usuario = Usuario.fromJson(await _sharedPreference.read('usuario'));
    print("usuario store categorie: ${usuario}");
    _categoriaProvider.init(context,sessionUser:usuario);
    _productoProvider.init(context,sessionUser:usuario);
    getCategorias();
  }

  void getCategorias()async{
    categorias = await _categoriaProvider.getAll();
    refresh();
  }

  Future selectImage(ImageSource imageSource,int numberFile)async{
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null){

      if(numberFile == 1){
        imageFile1 = File(pickedFile.path);
      }else if( numberFile == 2){
        imageFile2 = File(pickedFile.path);
      }else if( numberFile == 3){
        imageFile3 = File(pickedFile.path);
      }
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int numberFile) {
    Widget galleryButton = ElevatedButton(onPressed: (){ selectImage(ImageSource.gallery,numberFile); }, child: Text('Galería'));
    Widget cameraButton = ElevatedButton(onPressed: (){ selectImage(ImageSource.camera,numberFile); }, child: Text('Cámara'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });

  }

  void crearProducto()async{
    String nombre = nombreController.text;
    String descripcion = descripcionController.text;
    double precio = priceController.numberValue;

    if(nombre.isEmpty || descripcion.isEmpty || precio  == 0){
      MySnackBar.show(context, 'Debe ingresar todos los campos');
      return;
    }
    if(imageFile1 == null){
      MySnackBar.show(context, 'Selecciona al menos 1 imagen');
      return;
    }

    if(idCategoria == null){
      MySnackBar.show(context, 'Selecciona una categoría');
      return;
    }
   Producto producto = new Producto(
      nombre: nombre,
      descripcion: descripcion,
     precio: precio,
     categoriaId: int.parse(idCategoria)
   );
    List<File> imagenes = [];
    imagenes.add(imageFile1);
    imagenes.add(imageFile2);
    imagenes.add(imageFile3);
    _progressDialog.show(max: 100, msg: "Espere un momento");
    print("producto: ${ producto.toJson() }");
    Stream stream  = await _productoProvider.create(producto, imagenes);
    stream.listen((res){
      _progressDialog.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackBar.show(context, responseApi.message);
      if(responseApi.success){
        resetValues();
      }
    });
  }

  void resetValues(){
    nombreController.text = "";
    descripcionController.text = "";
    priceController.text = '0.0';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategoria =  null;

    refresh();

  }



}