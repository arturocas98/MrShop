import 'package:flutter/material.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/src/providers/usuario_provider.dart';

class RegisterController{
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nombresController = new TextEditingController();
  TextEditingController apellidosController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsuarioProvider usuarioProvider = new UsuarioProvider();

  Future init(BuildContext context){
    this.context = context;
    usuarioProvider.init(context);
  }


  void registerButton()async{

    String email = emailController.text.trim();
    String nombres = nombresController.text.trim();
    String apellidos = apellidosController.text.trim();
    String telefono = telefonoController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    Usuario usuario = new Usuario(

      nombre: nombres,
      apellido: apellidos,
      telefono: telefono,
      password: password,
      email: email,
    );
    ResponseApi responseApi = await usuarioProvider.create(usuario);

    print('respuesta: ${responseApi.toJson()} ');

    print('email $email');
    print('nombres $nombres');
    print('apellidos $apellidos');
    print('telefono $telefono');
    print('password $password');
    print('confirmPassword $confirmPassword');

  }



}