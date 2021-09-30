import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/pages/store/categories/create/store_categorie_create_controller.dart';
import 'package:mr_shop/utils/my_colors.dart';

class StoreCategorieCreatePage extends StatefulWidget {
  const StoreCategorieCreatePage({Key key}) : super(key: key);

  @override
  _StoreCategorieCreatePageState createState() =>
      _StoreCategorieCreatePageState();
}

class _StoreCategorieCreatePageState extends State<StoreCategorieCreatePage> {

  StoreCategorieCreateController controller = new StoreCategorieCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva Categoria"),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          _textFieldNombreCategoria(),
          _textFieldDescripcionCategoria()
        ],
      ),
      bottomNavigationBar: _buttonRegistrate(),
    );
  }

  Widget _textFieldNombreCategoria() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: controller.nombreController,
        decoration: InputDecoration(
            labelText: 'Nombre',
            hintText: 'Nombre',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.list_alt,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldDescripcionCategoria() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: controller.descripcionController,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
            labelText: 'Descripción',
            //hintText: 'Nombre',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.description,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _buttonRegistrate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
      child: ElevatedButton(
        onPressed: controller.crearCategoria,
        child: Text('Registrar'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}
