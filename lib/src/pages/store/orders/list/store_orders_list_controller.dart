
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/utils/shared_preference.dart';

class StoreOrdersListController{
  BuildContext context;
  SharedPreference _sharedPreference = new SharedPreference();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Usuario usuario;
  Function refresh;
  Future init(BuildContext context,Function refresh)async{
    this.context = context;
    usuario = Usuario.fromJson(await _sharedPreference.read('usuario'));
    this.refresh = refresh;
    refresh();
  }

  void logout()async{
    _sharedPreference.logout(context,usuario.id);
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  void openDrawer(){
    key.currentState.openDrawer();
  }

}