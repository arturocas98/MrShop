import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mr_shop/src/providers/usuario_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
  void save(String key,value)async{
    final preference = await SharedPreferences.getInstance();
    preference.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key)async{
    final preference = await SharedPreferences.getInstance();
    
    if(preference.getString(key) == null){
      return null;
    }
    return json.decode(preference.getString(key));
  }

  Future<bool> contains(String key)async{
    final preference = await SharedPreferences.getInstance();
    return preference.containsKey(key);
  }
  Future<bool> remove(String key)async{
    final preference = await SharedPreferences.getInstance();
    return preference.remove(key);
  }

  void logout(BuildContext context, String idUser) async {
    UsuarioProvider usersProvider = new UsuarioProvider();
    usersProvider.init(context);
    await usersProvider.logout(idUser);
    await remove('usuario');
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }



}