import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/src/providers/usuario_provider.dart';
import 'package:mr_shop/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController{
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nombresController = new TextEditingController();
  TextEditingController apellidosController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsuarioProvider usuarioProvider = new UsuarioProvider();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;
  ProgressDialog _progressDialog;
  bool is_enable = true;
  Future init(BuildContext context,Function refresh){
    this.context = context;
    usuarioProvider.init(context);
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);

  }


  void registerButton()async{

    String email = emailController.text.trim();
    String nombres = nombresController.text.trim();
    String apellidos = apellidosController.text.trim();
    String telefono = telefonoController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if(email.isEmpty || nombres.isEmpty || apellidos.isEmpty || telefono.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      MySnackBar.show(context, "Debes ingresar todos los campos");
      return;
    }

    if(confirmPassword != password){
      MySnackBar.show(context, "Las contraseñas no coinciden" );
      return;
    }

    if(password.length < 6 ){
      MySnackBar.show(context, "La contraseña debe tener al menos 6 caracteres" );
      return;
    }

    if(imageFile == null){
      MySnackBar.show(context, "Por favor selecciona una imagen" );
      return;
    }

    _progressDialog.show(max:100,msg:"Espere un momento...");
    is_enable = false;
    Usuario usuario = new Usuario(

      nombre: nombres,
      apellido: apellidos,
      telefono: telefono,
      password: password,
      email: email,
    );

    Stream stream = await usuarioProvider.createWithImage(usuario, imageFile);
    stream.listen((resp) {

      _progressDialog.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(resp));
      /*ResponseApi responseApi = await usuarioProvider.create(usuario);*/

      MySnackBar.show(context, responseApi.message);

      if(responseApi.success){
        Future.delayed(Duration(seconds: 3),(){
          Navigator.pushReplacementNamed(context, 'login');
        });
      }else{
        is_enable = true;
      }

    });



    /*print('respuesta: ${responseApi.toJson()} ');*/

    print('email $email');
    print('nombres $nombres');
    print('apellidos $apellidos');
    print('telefono $telefono');
    print('password $password');
    print('confirmPassword $confirmPassword');

  }

  void back(){
    Navigator.pop(context);
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