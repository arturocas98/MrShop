import 'package:flutter/material.dart';
import 'package:mr_shop/src/pages/client/products/list/product_list_page.dart';
import 'package:mr_shop/src/pages/client/update/client_update_page.dart';
import 'package:mr_shop/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:mr_shop/src/pages/introduction/introduction_page.dart';
import 'package:mr_shop/src/pages/login/login_page.dart';
import 'package:mr_shop/src/pages/register/register_page.dart';
import 'package:mr_shop/src/pages/roles/roles_page.dart';
import 'package:mr_shop/src/pages/store/categories/create/store_categorie_create_page.dart';
import 'package:mr_shop/src/pages/store/orders/list/store_orders_list_page.dart';
import 'package:mr_shop/src/pages/store/products/create/store_products_create_page.dart';
import 'package:mr_shop/utils/my_colors.dart';
import 'package:mr_shop/utils/shared_preference.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreference sharedPreference;
  Object intro;

  initPrefs()async{
    sharedPreference = new SharedPreference();
    intro =  await sharedPreference.read('intro');
    intro != false || intro == null ?  sharedPreference.save('intro', true): sharedPreference.save('intro',false);
    //print("show intro: ${intro}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mr Shop',
      initialRoute:  intro == true || intro == null ?'intro':'login',
      debugShowCheckedModeBanner: false,
      routes:{
        'intro': (BuildContext context) => IntroductionPage(),
       'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'client/products/list': (BuildContext context) => ProductListPage(),
        'client/update': (BuildContext context) => ClientUpdatePage(),
        'store/orders/list': (BuildContext context) => StoreOrdersListPage(),
        'store/categorie/create': (BuildContext context) => StoreCategorieCreatePage(),
        'store/products/create': (BuildContext context) => StoreProductsCreatePage(),
        'delivery/orders/list': (BuildContext context) => DeliveryOrdersListPage(),
        'roles': (BuildContext context) => RolesPage()
      },
      theme: (
        ThemeData(
          primaryColor: MyColors.primaryColorDark,
          appBarTheme: AppBarTheme(elevation:0)
        )
      ),
    );
  }
}

