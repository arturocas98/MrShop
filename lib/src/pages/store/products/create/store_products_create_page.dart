import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/models/categoria.dart';
import 'package:mr_shop/src/pages/store/products/create/store_products_create_controller.dart';
import 'package:mr_shop/utils/my_colors.dart';

class StoreProductsCreatePage extends StatefulWidget {
  const StoreProductsCreatePage({Key key}) : super(key: key);

  @override
  _StoreProductsCreatePageState createState() => _StoreProductsCreatePageState();
}

class _StoreProductsCreatePageState extends State<StoreProductsCreatePage> {
  StoreProductsCreateController controller = new StoreProductsCreateController();

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
        title: Text("Nuevo producto"),
        backgroundColor: MyColors.primaryColor,
      ),
      body:  ListView(
          children: [
            SizedBox(height: 30),
            _textFieldNombreProducto(),
            _textFieldDescripcionProducto(),
            _textFieldPrecioProducto(),
            Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(controller.imageFile1,1),
                _cardImage(controller.imageFile2,2),
                _cardImage(controller.imageFile3,3)
              ],
            ),
            ),
            _dropdownSelect(controller.categorias)

            ],
      ),
      bottomNavigationBar: _buttonRegistrate(),
    );
  }

  Widget _textFieldNombreProducto() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        maxLines: 1,
        maxLength: 180,
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
              Icons.inventory_2_outlined,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldDescripcionProducto() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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
              Icons.description_outlined,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldPrecioProducto() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        maxLines: 1,
        keyboardType: TextInputType.phone,
        controller: controller.priceController,
        decoration: InputDecoration(
            labelText: 'Precio',
            hintText: '0,0',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.monetization_on_outlined,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _cardImage(File file,int num){
    return GestureDetector(
      onTap: (){controller.showAlertDialog(num);},
      child: file != null ?
      Card(
        elevation: 3.0,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.26,
          child: Image.file(
            file,
            fit: BoxFit.cover,

          ),
        ),
      ):
      Card(
        elevation: 3.0,
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.26,
          child: Image(
            image: AssetImage('assets/img/add_image.png'),

          ),
        ),
      ),
    );

  }

  Widget _dropdownSelect(List<Categoria>categorias){
    return Container(
      margin:EdgeInsets.symmetric(horizontal: 35),
      child: Material(
        elevation:2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)) ,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(

                children: [
                  Icon(
                    Icons.search,
                    color:MyColors.primaryColor
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Categorias',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle_outlined
                    ),
                  ),
                  elevation: 3,
                  isExpanded:true,
                  hint: Text(
                    'Seleccionar categoria',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      )
                  ),
                  items: _dropDownItems(categorias),
                  value: controller.idCategoria,
                  onChanged: (option){
                    setState(() {
                      controller.idCategoria = option;
                    });
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    ) ;
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Categoria>categorias){
    List<DropdownMenuItem<String>> list = [];
    categorias.forEach((categoria) {
      list.add(DropdownMenuItem(
        child: Text(categoria.nombre),
        value: categoria.id
      ));
    });
    return list;
  }

  Widget _buttonRegistrate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
      child: ElevatedButton(
        onPressed: controller.crearProducto,
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
