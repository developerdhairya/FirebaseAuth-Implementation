import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vartaa_messenger/pages/login_page.dart';
import 'package:vartaa_messenger/pages/registeration_page.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VartaaMessenger());
}

class VartaaMessenger extends StatefulWidget {
  const VartaaMessenger({Key? key}) : super(key: key);

  @override
  _VartaaMessengerState createState() => _VartaaMessengerState();
}

class _VartaaMessengerState extends State<VartaaMessenger> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vartaa Messenger",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(42,117,188,1),
        accentColor: Color.fromRGBO(42,117,188,1),
        backgroundColor: Color.fromRGBO(28,27,27,1),
        primarySwatch: Colors.blue,
      ),
      home: RegistrationPage(),
    );
  }
}
