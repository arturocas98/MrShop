import 'package:flutter/material.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/utils/shared_preference.dart';
class RolesController{
  BuildContext context;
  Function refresh;
  SharedPreference _sharedPreference = new SharedPreference();
  Usuario usuario;
  Future init(BuildContext context, Function refresh)async{
    this.context = context;
    this.refresh = refresh;
    usuario = Usuario.fromJson(await _sharedPreference.read('usuario'));
    refresh();
  }

  void goToPage(String ruta){
    Navigator.pushNamedAndRemoveUntil(context, ruta, (route) => false);
  }

}