import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vartaa_messenger/providers/auth_provider.dart';
import 'package:vartaa_messenger/services/navigation_service.dart';
import 'package:vartaa_messenger/services/snackbar_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceWidth;
  late double _deviceHeight;

  late GlobalKey<FormState> _formKey;
  late AuthProvider _authProvider;

  late String _email;
  late String _password;

  _LoginPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    SnackBarService.instance.buildContext = context;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _loginPageUI(),
      ),
    );
  }

  Widget _loginPageUI() {
    return Builder(
      builder: (_context) {
        _authProvider = Provider.of<AuthProvider>(_context);
        return Center(
          child: Container(
            height: _deviceHeight * 0.60,
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headingWidget(),
                _inputForm(),
                _loginButton(),
                _registerButton()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _headingWidget() {
    return Container(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Please Log In to your account",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [_emailTextField(), _passwordTextField()],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        return value!.length != 0 && value.contains('@')
            ? null
            : "Please Enter a valid Email";
      },
      onSaved: (newValue) {
        // setState(() {
          _email = newValue!;
        // });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Email Address",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        return value!.length > 8
            ? null
            : "Password should be more than 8 characters";
      },
      onSaved: (newValue) {
        // setState(() {
          _password = newValue!;
        // });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Password",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return _authProvider.status == AuthStatus.Authenticating
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: _deviceHeight * 0.06,
            width: _deviceWidth,
            child: MaterialButton(
              height: _deviceHeight * 0.06,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  {
                    _authProvider.loginUserWithEmailAndPassword(
                        _email, _password);
                  }
                }
              },
              color: Colors.blue,
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          );
  }

  Widget _registerButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.navigateTo("/register");
      },
      child: Container(
        height: _deviceWidth * 0.06,
        width: _deviceWidth,
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white60),
        ),
      ),
    );
  }
}
