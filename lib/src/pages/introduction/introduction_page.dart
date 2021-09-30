import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mr_shop/utils/my_colors.dart';
import 'package:mr_shop/utils/shared_preference.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  SharedPreference  sharedPreference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPreference = new SharedPreference();

  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      done: Text(
        'hecho',
        style:TextStyle(
          color: Colors.black
        ),
      ),
      onDone: (){ sharedPreference.save('intro',false); Navigator.pushNamed(context, 'login'); },
      pages: [
        PageViewModel(
          title: "Encuentra lo que necesitas",
          body:
          "Sin salir de casa encuentra de todo en nuestra app.",
          image: _buildImage('intro1.jpg'),
        ),
        PageViewModel(
          title: "Lo empacamos por ti",
          body:
          "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('intro2.jpg'),
        ),
      ],
      globalBackgroundColor: Colors.white,
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
        showNextButton:true,
      skip: const Text('Saltar'),
      next: const Icon(Icons.arrow_forward),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/img/$assetName', width: width);
  }

}
