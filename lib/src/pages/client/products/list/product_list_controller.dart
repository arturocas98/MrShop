
import 'package:flutter/cupertino.dart';
import 'package:mr_shop/utils/shared_preference.dart';

class ProductListController{
  BuildContext context;
  SharedPreference _sharedPreference = new SharedPreference();

  Future init(BuildContext context){
    this.context = context;
  }

  void logout()async{
    _sharedPreference.remove('usuario');
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

}