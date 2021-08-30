import 'package:flutter/material.dart';

class StoreOrdersListPage extends StatefulWidget {
  const StoreOrdersListPage({Key key}) : super(key: key);

  @override
  _StoreOrdersListPageState createState() => _StoreOrdersListPageState();
}

class _StoreOrdersListPageState extends State<StoreOrdersListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text(
          "Store List Page"
        ),
      )
    );
  }
}
