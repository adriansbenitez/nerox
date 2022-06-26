import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(Images.logo),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 300),
            child: SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2),
            ),
          )
        ],
      ),
    );
  }
}
