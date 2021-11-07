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
          textProductDescription()
        ],
      )
    );
  }

  Widget textProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30,right: 30,top: 15),
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

  Widget imageSlideShow(){
    return ImageSlideshow(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      initialPage: 0,
      indicatorColor: MyColors.primaryColor,
      indicatorBackgroundColor: Colors.grey,
      onPageChanged: (value) {
        debugPrint('Page changed: $value');
      },
      autoPlayInterval: 7000,
      isLoop: true,
      children: [
        FadeInImage(
          image: _con.producto.imagen1 != null
              ? NetworkImage(_con.producto?.imagen1)
              : AssetImage('assets/img/no-image.png'),
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
        FadeInImage(
          image: _con.producto.imagen2 != null
              ? NetworkImage(_con.producto?.imagen2)
              : AssetImage('assets/img/no-image.png'),
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
        FadeInImage(
          image: _con.producto.imagen3 != null
              ? NetworkImage(_con.producto?.imagen3)
              : AssetImage('assets/img/no-image.png'),
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      ],
    );
  }

  void refresh(){
    setState(() {

    });
  }
}
