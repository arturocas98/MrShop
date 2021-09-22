import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/src/providers/usuario_provider.dart';
import 'package:mr_shop/utils/my_snackbar.dart';
import 'package:mr_shop/utils/shared_preference.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController{
  BuildContext context;
  TextEditingController nombresController = new TextEditingController();
  TextEditingController apellidosController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();

  UsuarioProvider usuarioProvider = new UsuarioProvider();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;
  ProgressDialog _progressDialog;
  bool is_enable = true;
  SharedPreference _sharedPreference = new SharedPreference();
  Usuario usuario;


  Future init(BuildContext context,Function refresh)async{
    this.context = context;
    this.refresh = refresh;

    usuario = Usuario.fromJson(await _sharedPreference.read('usuario'));
    print("usuario: $usuario");
    usuarioProvider.init(context,sessionUser:usuario);

    /*Set user data in text editing*/
    nombresController.text = usuario.nombre;
    apellidosController.text = usuario.apellido;
    telefonoController.text = usuario.telefono;


    _progressDialog = ProgressDialog(context: context);
    refresh();
  }


  void updateButton()async{

    String nombres = nombresController.text.trim();
    String apellidos = apellidosController.text.trim();
    String telefono = telefonoController.text.trim();

    if( nombres.isEmpty || apellidos.isEmpty || telefono.isEmpty){
      MySnackBar.show(context, "Debes ingresar todos los campos");
      return;
    }



    /*if(imageFile == null){
      MySnackBar.show(context, "Por favor selecciona una imagen" );
      return;
    }*/

    _progressDialog.show(max:100,msg:"Espere un momento...");
    is_enable = false;
    Usuario usuario = new Usuario(
      id: this.usuario.id,
      nombre: nombres,
      apellido: apellidos,
      telefono: telefono,
      imagen:this.usuario.imagen
    );

    Stream stream = await usuarioProvider.update(usuario, imageFile);
    stream.listen((resp)async {

      _progressDialog.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(resp));

      Fluttertoast.showToast(msg: responseApi.message);


      if(responseApi.success){

        /*Se obtiene el usuario actualizado*/
        this.usuario = await usuarioProvider.getUserById(this.usuario.id);
        _sharedPreference.save('usuario', this.usuario.toJson());
        Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
      }else{
        is_enable = true;
      }

    });
    /*print('respuesta: ${responseApi.toJson()} ');*/

  }

  Future selectImage(ImageSource imageSource)async{
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null){
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(onPressed: (){ selectImage(ImageSource.gallery); }, child: Text('Galería'));
    Widget cameraButton = ElevatedButton(onPressed: (){ selectImage(ImageSource.camera); }, child: Text('Cámara'));

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



}