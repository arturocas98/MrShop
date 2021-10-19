import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/pages/store/orders/list/store_orders_list_controller.dart';
import 'package:mr_shop/utils/my_colors.dart';

class StoreOrdersListPage extends StatefulWidget {
  const StoreOrdersListPage({Key key}) : super(key: key);

  @override
  _StoreOrdersListPageState createState() => _StoreOrdersListPageState();
}

class _StoreOrdersListPageState extends State<StoreOrdersListPage> {
  StoreOrdersListController _storeOrdersListController = StoreOrdersListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _storeOrdersListController.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _storeOrdersListController.key,
      appBar: AppBar(
        leading: _menuDrawer(),
        backgroundColor: MyColors.primaryColor,
      ),
      drawer: _drawer(),
      body: Center(
        child: Text(
            "Tienda List"
        ),
      ),
    );
  }


  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _storeOrdersListController.openDrawer,
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
                    '${ _storeOrdersListController.usuario?.nombre ?? '' } ${ _storeOrdersListController.usuario?.apellido ?? ''}  ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _storeOrdersListController.usuario?.email ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _storeOrdersListController.usuario?.telefono ?? '',
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
                      image: _storeOrdersListController.usuario?.imagen != null
                          ? NetworkImage(_storeOrdersListController.usuario?.imagen)
                          :AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )
          ),
         /* ListTile(
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),*/
          _storeOrdersListController.usuario != null ?
          _storeOrdersListController.usuario.roles.length > 1 ?
          ListTile(
            onTap: (){ Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false); },
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outlined),
          ):Container():Container(),
          ListTile(
            onTap: (){ Navigator.pushNamed(context, 'store/categorie/create');},
            title: Text('Categoria'),
            trailing: Icon(Icons.category_outlined),
          ),
          ListTile(
            onTap: (){ Navigator.pushNamed(context, 'store/products/create');},
            title: Text('Productos'),
            trailing: Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: _storeOrdersListController.logout,
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
