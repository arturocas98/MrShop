import 'package:flutter/material.dart';
import 'package:mr_shop/src/pages/client/products/list/product_list_page.dart';
import 'package:mr_shop/src/pages/client/update/client_update_page.dart';
import 'package:mr_shop/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:mr_shop/src/pages/login/login_page.dart';
import 'package:mr_shop/src/pages/register/register_page.dart';
import 'package:mr_shop/src/pages/roles/roles_page.dart';
import 'package:mr_shop/src/pages/store/orders/list/store_orders_list_page.dart';
import 'package:mr_shop/utils/my_colors.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mr Shop',
      initialRoute: 'login',
      debugShowCheckedModeBanner: false,
      routes:{
       'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'client/products/list': (BuildContext context) => ProductListPage(),
        'client/update': (BuildContext context) => ClientUpdatePage(),
        'store/orders/list': (BuildContext context) => StoreOrdersListPage(),
        'delivery/orders/list': (BuildContext context) => DeliveryOrdersListPage(),
        'roles': (BuildContext context) => RolesPage()
      },
      theme: (
        ThemeData(

          primaryColor: MyColors.primaryColor
        )
      ),
    );
  }
}

