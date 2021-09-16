import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mr_shop/src/pages/register/register_controller.dart';
import 'package:mr_shop/utils/my_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  RegisterController registerController = new RegisterController();

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
      registerController.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Stack(children: [
              Positioned(top: -80, left: -100, child: _circleRegister()),
              Positioned(top: 60, left: 25, child: _textRegister()),
              Positioned(top: 50, left: -5, child: _iconBack()),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 150),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _imageUser(),
                      SizedBox(
                        height: 30,
                      ),
                      _textFieldCorreo(),
                      _textFieldNombres(),
                      _textFieldApellidos(),
                      _textFieldTelefono(),
                      _textFieldPassword(),
                      _textFieldConfirmPassword(),
                      _buttonRegistrate()
                    ],
                  ),
                ),
              )
            ])));
  }

  Widget _iconBack() {
    return IconButton(
        onPressed: registerController.back,
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ));
  }

  Widget _textRegister() {
    return Text(
      'Registro',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: ('NimbusSans')),
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: registerController.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: registerController.imageFile != null
          ? FileImage(registerController.imageFile)
          : AssetImage('assets/img/user_profile_2.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _circleRegister() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  Widget _textFieldCorreo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: registerController.emailController,
        decoration: InputDecoration(
            hintText: 'Correo electrónico',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )),
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
        controller: registerController.nombresController,
        decoration: InputDecoration(
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
        controller: registerController.apellidosController,
        decoration: InputDecoration(
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
        controller: registerController.telefonoController,
        decoration: InputDecoration(
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

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: registerController.passwordController,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: GestureDetector(
              onTap: _showPassword,
              child: Icon(
                _obscureText ?Icons.visibility : Icons.visibility_off,
                color: MyColors.primaryColor,
              ),
            )),
        obscureText: _obscureText,
      ),
    );
  }

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: registerController.confirmPasswordController,
        decoration: InputDecoration(
            hintText: 'Confirmar contraseña',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: GestureDetector(
              onTap: _showPasswordConfirm,
              child: Icon(
                _obscureTextConfirm ?Icons.visibility : Icons.visibility_off,
                color: MyColors.primaryColor,
              ),
            )),
        obscureText: _obscureTextConfirm,
      ),
    );
  }

  Widget _buttonRegistrate() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
      child: ElevatedButton(
        onPressed:  registerController.is_enable ?registerController.registerButton:null,
        child: Text('Registrar'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }

}
