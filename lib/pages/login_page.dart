import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late double _deviceWidth;
  late double _deviceHeight;

  @override
  Widget build(BuildContext context) {

    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceWidth=MediaQuery.of(context).size.width;


    return Scaffold(
      body: _loginPageUI(),
    );
  }

  Widget _loginPageUI(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        ],
      ),
    );
  }
}
