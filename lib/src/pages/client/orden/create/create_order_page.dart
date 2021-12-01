import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/models/producto.dart';
import 'package:mr_shop/src/pages/client/orden/create/create_order_page_controller.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key key}) : super(key: key);

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {

  CreateOrderPageController _con = new CreateOrderPageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Orden'),
      ),
      body: ListView(
        children: [],
      ),
    );
  }

  Widget cardProduct(Producto producto){
    return Container();
  }
}
