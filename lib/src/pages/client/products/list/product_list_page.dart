import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/models/categoria.dart';
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
      _productListController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _productListController.categorias?.length,
      child: Scaffold(
          key: _productListController.key,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(170),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: MyColors.primaryColor,
              actions: [
                _shoppingBag()
              ],
              flexibleSpace: Column(
                children: [
                  SizedBox(height: 20),
                  _menuDrawer(),
                  SizedBox(height: 20),
                  _textFieldSearch()
                ],
              ),
              bottom: TabBar(
                  indicatorColor: MyColors.primaryColor,
                  labelColor:  Colors.white,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: List<Widget>.generate(_productListController.categorias.length,(index){
                    return Tab(
                      child: Text(
                          _productListController.categorias[index].nombre ?? ''
                      ),
                    );
                  })
              ),
            ),
          ),
          drawer: _drawer(),
          body: TabBarView(
            children: _productListController.categorias.map((Categoria categoria){
              return _cardProduct();
            }).toList(),
          )
      ),
    );
  }

  Widget _shoppingBag(){
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 15,top: 13),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
        ),
        Positioned(
          right: 16,
          top: 13,
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          ),
        )
      ],
    );
  }

  Widget _textFieldSearch(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Buscar',
            suffixIcon: Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            hintStyle: TextStyle(
                fontSize: 17,
                color:Colors.white
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                    color:Colors.white
                )
            ),
            focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                    color:Colors.white
                )
            ),
            contentPadding: EdgeInsets.all(15)
        ),
      ),
    );
  }
  
  Widget _cardProduct(){
    return Container(
      height: 250,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Stack(
          children: [
            Positioned(
              top: -1.0,
              right: -1.0,
              child:Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(30)
                  )
                ),
                child: Icon(Icons.add,color: Colors.white,),
              )
            ),
            Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(20),
                    child: FadeInImage(
                      image: AssetImage('assets/img/pizza2.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Nombre del producto',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NimbusSans'
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      '0.0\$',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NimbusSans'
                    ),
                  ),
                )
              ],
            )
          ],
        ),

      ),
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
                    '${_productListController.usuario?.nombre ?? ''} ${_productListController.usuario?.apellido ?? ''}  ',
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
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'client/update');
            },
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
          _productListController.usuario != null
              ? _productListController.usuario.roles.length > 1
              ? ListTile(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'roles', (route) => false);
            },
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outlined),
          )
              : Container()
              : Container(),
          ListTile(
            onTap: _productListController.logout,
            title: Text('Cerrar sesión'),
            trailing: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
