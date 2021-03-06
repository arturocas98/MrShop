import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:mr_shop/utils/my_colors.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({Key key}) : super(key: key);

  @override
  _DeliveryOrdersListPageState createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {

  DeliveryOrdersListController _deliveryOrdersListController = DeliveryOrdersListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _deliveryOrdersListController.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _deliveryOrdersListController.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center(
        child: Text(
          "Repartidor List"
        ),
      ),
    );
  }


  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _deliveryOrdersListController.openDrawer,
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
                    '${ _deliveryOrdersListController.usuario?.nombre ?? '' } ${ _deliveryOrdersListController.usuario?.apellido ?? ''}  ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _deliveryOrdersListController.usuario?.email ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _deliveryOrdersListController.usuario?.telefono ?? '',
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
                      image: _deliveryOrdersListController.usuario?.imagen != null
                          ? NetworkImage(_deliveryOrdersListController.usuario?.imagen)
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
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
          _deliveryOrdersListController.usuario != null ?
          _deliveryOrdersListController.usuario.roles.length > 1 ?
          ListTile(
            onTap: (){ Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false); },
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outlined),
          ):Container():Container(),
          ListTile(
            onTap: _deliveryOrdersListController.logout,
            title: Text('Cerrar sesi??n'),
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

