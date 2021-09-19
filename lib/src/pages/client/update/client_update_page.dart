import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/pages/client/update/client_update_controller.dart';
import 'package:mr_shop/utils/my_colors.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({Key key}) : super(key: key);

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  ClientUpdateController clientUpdateController = new ClientUpdateController();

  void _showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showPasswordConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      clientUpdateController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Editar Perfil"
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              _imageUser(),
              SizedBox(
                height: 30,
              ),
              _textFieldNombres(),
              _textFieldApellidos(),
              _textFieldTelefono(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonActualizar(),
    );
  }


  Widget _imageUser() {
    return GestureDetector(
      onTap: clientUpdateController.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: clientUpdateController.imageFile != null
            ? FileImage(clientUpdateController.imageFile)
            :  clientUpdateController.usuario?.imagen !=null
            ? NetworkImage(clientUpdateController.usuario?.imagen)
            :AssetImage('assets/img/no-image.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }



  Widget _textFieldNombres() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: clientUpdateController.nombresController,
        decoration: InputDecoration(
          labelText: 'Nombres',
            hintText: 'Nombres',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldApellidos() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: clientUpdateController.apellidosController,
        decoration: InputDecoration(
          labelText: 'Apellidos',
            hintText: 'Apellidos',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldTelefono() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: clientUpdateController.telefonoController,
        decoration: InputDecoration(
          labelText: 'Teléfono',
            hintText: 'Teléfono',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.phone,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _buttonActualizar() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
      child: ElevatedButton(
        onPressed: clientUpdateController.is_enable
            ? clientUpdateController.updateButton
            : null,
        child: Text('Actualizar perfil'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
