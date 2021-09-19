import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/pages/client/products/list/product_list_controller.dart';
import 'package:mr_shop/utils/my_colors.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductListController _productListController = new ProductListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _productListController.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _productListController.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center(
          child: ElevatedButton(
        onPressed: _productListController.logout,
        child: Text('Cerrar Sesión'),
      )),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _productListController.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/img/menu.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ _productListController.usuario?.nombre ?? '' } ${ _productListController.usuario?.apellido ?? ''}  ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _productListController.usuario?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _productListController.usuario?.telefono ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _productListController.usuario?.imagen != null
                            ? NetworkImage(_productListController.usuario?.imagen)
                            :AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )
          ),
          ListTile(
            onTap: (){ Navigator.pushNamed(context, 'client/update'); },
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
          _productListController.usuario != null ?
          _productListController.usuario.roles.length > 1 ?
          ListTile(
            onTap: (){ Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false); },
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outlined),
          ):Container():Container(),
          ListTile(
            onTap: _productListController.logout,
            title: Text('Cerrar sesión'),
            trailing: Icon(Icons.power_settings_new),
          ),

        ],
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}
