import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:mr_shop/src/models/producto.dart';
import 'package:mr_shop/src/pages/client/products/detail/product_detail_page_controller.dart';
import 'package:mr_shop/utils/my_colors.dart';


class ProductDetailPage extends StatefulWidget {
  Producto producto;
  ProductDetailPage({Key key, @required this.producto }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductDetailPageController _con = new  ProductDetailPageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh,widget.producto);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          imageSlideShow(),
          textProduct(),
          textProductDescription(),
          Spacer(),
          addCantidad(),
          standarDelivery(),
          buttonShoppingBag()
        ],
      )
    );
  }

  Widget textProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30,right: 30,top: 30),
      child: Text(
        _con.producto?.nombre ?? '',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget textProductDescription(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30,right: 30,top: 15),
      child: Text(
        _con.producto?.descripcion ?? '',
        style: TextStyle(
            fontSize: 13,
            color: Colors.grey
        ),
      ),
    );
  }

  Widget addCantidad(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          IconButton(
            onPressed: _con.removeProducto,
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child:Text(
              '${_con.cantidad}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 17
              ),
            ),
          ),
          IconButton(
            onPressed: _con.addProducto,
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 20),
            child:Text(
              '\$${_con.precioProducto ?? 0}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ],
      ),
    );
  }

  Widget standarDelivery(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          children: [
            Image.asset(
              'assets/img/delivery.png',
              height: 17,
            ),
            SizedBox(width: 7),
            Text(
              'Envio estandar',
              style:TextStyle(
                color: Colors.green,
                fontSize: 12
              )
            )
          ],
        ),
    );
  }

  Widget buttonShoppingBag(){
    return Container(
      margin: EdgeInsets.only(left: 30,right: 30,top: 30,bottom: 30),
      child: ElevatedButton(
        onPressed: _con.anadirCarrito,
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  'Agregar al carrito',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:Container(
                margin: EdgeInsets.only(left: 50,top: 6),
                height: 30,
                child: Image.asset(
                  'assets/img/bag.png'
                ),
              )
            )
          ],

        ),
      ),
    );
  }

  Widget imageSlideShow(){
    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.40,
          initialPage: 0,
          indicatorColor: MyColors.primaryColor,
          indicatorBackgroundColor: Colors.grey,
          onPageChanged: (value) {
            /*debugPrint('Page changed: $value');*/
          },
          autoPlayInterval: 7000,
          isLoop: true,
          children: [
            FadeInImage(
              image: _con.producto?.imagen1 != null
                  ? NetworkImage(_con.producto?.imagen1)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.producto?.imagen2 != null
                  ? NetworkImage(_con.producto?.imagen2)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.producto?.imagen3 != null
                  ? NetworkImage(_con.producto?.imagen3)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ],
        ),
        Positioned(
          left: 10,
          top: 5,
          child: IconButton(
            onPressed: _con.closeModal,
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.primaryColor,
            ),
          ),
        )
      ],

    );
  }

  void refresh(){
    setState(() {

    });
  }
}
