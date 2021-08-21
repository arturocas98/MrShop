import 'package:flutter/material.dart';
class LoginController{
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passworController = new TextEditingController();

  Future init(BuildContext context){
    this.context = context;
  }

  void goinToRegisterPage(){
    Navigator.pushNamed(context, 'register');
  }

  void loginButton(){
    String email = emailController.text.trim();
    String password = passworController.text.trim();

    print('email: $email');
    print('password: $password');

  }
}