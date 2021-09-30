import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_shop/src/pages/login/LoginController.dart';
import 'package:mr_shop/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = new LoginController();

  bool _obscureText = true;

  void _showPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      loginController.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Stack(children: [
          Positioned(top: -80, left: -100, child: _circleLogin()),
          Positioned(top: 60, left: 25, child: _textLogin()),
          Column(
            children: [
              /*_imageBanner(),*/
              _lottieAnimation(),
              _textFieldCorreo(),
              _textFieldPassword(),
              _buttonLogin(),
              _textNoTieneCuenta()
            ],
          ),
        ]),
      ),
    ));
  }

  Widget _textLogin() {
    return Text(
      'Login',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: ('NimbusSans')),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  Widget _lottieAnimation() {
    return Container(
      margin: EdgeInsets.only(
          top: 150, bottom: MediaQuery.of(context).size.height * 0.05),
      child: Lottie.asset('assets/json/delivery.json',
          width: 350, height: 200, fit: BoxFit.fill),
    );
  }

  Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(
          top: 100, bottom: MediaQuery.of(context).size.height * 0.12),
      child: Image.asset('assets/img/delivery.png', width: 200, height: 200),
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
        controller: loginController.emailController,
        decoration: InputDecoration(
            labelText: 'Correo electrónico',
            hintText: "Ingrese aquí su correo electrónico",
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

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: loginController.passworController,
        decoration: InputDecoration(
            labelText:"Contraseña",
            hintText: 'Ingrese una contraseña segura',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: GestureDetector(
              onTap: _showPassword,
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: MyColors.primaryColor,
              ),
            )),
        obscureText: _obscureText,
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
      child: ElevatedButton(
        onPressed: loginController.loginButton,
        child: Text('Iniciar sesión'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _textNoTieneCuenta() {
    return GestureDetector(
      onTap: loginController.goinToRegisterPage,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No tienes cuenta?',
            style: TextStyle(color: MyColors.primaryColor),
          ),
          SizedBox(
            width: 7,
          ),
          Text(
            'Registrate',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: MyColors.primaryColor),
          )
        ],
      ),
    );
  }
}
