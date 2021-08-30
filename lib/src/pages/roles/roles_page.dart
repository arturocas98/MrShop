import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/models/rol.dart';
import 'package:mr_shop/src/pages/roles/roles_controller.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _rolesController = new RolesController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _rolesController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Selecciona tu Rol'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
          child: ListView(
              children: _rolesController.usuario != null
                  ? _rolesController.usuario.roles.map((Rol rol) {
                      return _cardRol(rol);
                    }).toList()
                  : []),
        ));
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: (){_rolesController.goToPage(rol.ruta);},
      child: Column(
        children: [
          Container(
            height: 100,
            child: FadeInImage(
              image: rol.imagen != null
                  ? NetworkImage(rol.imagen)
                  : AssetImage("assets/img/no-image.png"),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          SizedBox(height: 15),
          Text(
            rol.nombre ?? '',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }

  Widget _cardRol2(Rol rol) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 150,
              child: FadeInImage(
                image: rol.imagen != null
                    ? NetworkImage(rol.imagen)
                    : AssetImage("assets/img/no-image.png"),
                fit: BoxFit.contain,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
            ),
            Text(
              rol.nombre ?? '',
              style: TextStyle(fontSize: 16, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
