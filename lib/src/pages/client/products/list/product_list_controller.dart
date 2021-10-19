
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_shop/src/models/categoria.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/src/providers/categoria_provider.dart';
import 'package:mr_shop/utils/shared_preference.dart';

class ProductListController{
  BuildContext context;
  SharedPreference _sharedPreference = new SharedPreference();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Usuario usuario;
  Function refresh;
  List<Categoria>categorias = [];
  CategoriaProvider _categoriaProvider = new CategoriaProvider();

  Future init(BuildContext context,Function refresh)async{
    this.context = context;
    usuario = Usuario.fromJson(await _sharedPreference.read('usuario'));
    this.refresh = refresh;
    this._categoriaProvider.init(context,sessionUser: usuario);
    getCategorias();
    refresh();
  }

  void getCategorias()async{
    categorias = await _categoriaProvider.getAll();
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