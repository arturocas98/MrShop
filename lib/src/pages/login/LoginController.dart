import 'package:flutter/material.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/src/providers/usuario_provider.dart';
import 'package:mr_shop/utils/my_snackbar.dart';
import 'package:mr_shop/utils/shared_preference.dart';
class LoginController{
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passworController = new TextEditingController();
  UsuarioProvider  usuarioProvider = new UsuarioProvider();
  SharedPreference _sharedPreference = new SharedPreference();

  Future init(BuildContext context)async{
    this.context = context;
    await usuarioProvider.init(context);
    Usuario usuario =  Usuario.fromJson(await _sharedPreference.read('usuario')?? {});

    if(usuario?.token != null){
      if(usuario.roles.length > 1){
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, usuario.roles[0].ruta, (route) => false);
      }
    }
  }

  void goinToRegisterPage(){
    Navigator.pushNamed(context, 'register');
  }

  void loginButton()async{
    String email = emailController.text.trim();
    String password = passworController.text.trim();
    if( email != '' && password != ''){
      ResponseApi responseApi =  await usuarioProvider.login(email, password);
      print("Response Api ${responseApi.toJson()}");

      if(responseApi.success){
        Usuario usuario = Usuario.fromJson(responseApi.data);
        _sharedPreference.save('usuario', usuario.toJson());

        if(usuario.roles.length > 1){
          Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, usuario.roles[0].ruta, (route) => false);
        }

      }else{
        MySnackBar.show(context, responseApi.message);
      }
      print('email: $email');
      print('password: $password');
    }else{
      MySnackBar.show(context,'Ingrese el usuario y contraseña');
    }
  }
}