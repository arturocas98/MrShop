import 'package:flutter/cupertino.dart';
import 'package:mr_shop/src/models/categoria.dart';
import 'package:mr_shop/src/models/response_api.dart';
import 'package:mr_shop/src/models/usuario.dart';
import 'package:mr_shop/src/providers/categoria_provider.dart';
import 'package:mr_shop/utils/my_snackbar.dart';
import 'package:mr_shop/utils/shared_preference.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class StoreCategorieCreateController {
  BuildContext context;
  Function refresh;
  CategoriaProvider categoriaProvider = new CategoriaProvider();
  TextEditingController nombreController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();
  ProgressDialog _progressDialog;
  bool is_enable = true;
  Usuario usuario;
  SharedPreference _sharedPreference = new SharedPreference();
  Future init(BuildContext context,Function refresh)async{
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context:context);
    usuario = Usuario.fromJson(await _sharedPreference.read('usuario'));
    print("usuario store categorie: ${usuario}");
    categoriaProvider.init(context,sessionUser:usuario);
  }

  void crearCategoria()async{
    String nombre = nombreController.text;
    String descripcion = descripcionController.text;

    if(nombre.isEmpty || descripcion.isEmpty){
      MySnackBar.show(context, 'Debe ingresar todos los campos');
    }else{
      _progressDialog.show(max:100,msg:"Espere un momento...");
      //is_enable = false;
      Categoria categoria = new Categoria(
        nombre: nombre,
        descripcion: descripcion,
      );

      ResponseApi responseApi =  await categoriaProvider.create(categoria);
      //print("Response Api ${responseApi.toJson()}");
      if(responseApi.success){
        _progressDialog.close();
        MySnackBar.show(context, responseApi.message);
        nombreController.text = '';
        descripcionController.text = '';

      }else{
        MySnackBar.show(context, responseApi.message);
        //is_enable = true;
      }
    }




  }



}