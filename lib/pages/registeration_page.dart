import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vartaa_messenger/providers/auth_provider.dart';
import 'package:vartaa_messenger/providers/user_image_provider.dart';

import 'package:vartaa_messenger/services/low-lvl/navigation_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late GlobalKey<FormState> _formKey;

  late double _deviceHeight;
  late double _deviceWidth;

  late String _name;
  late String _email;
  late String _password;

  late UserImageProvider _userImageProvider;
  late AuthProvider _authProvider;

  _RegistrationPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserImageProvider>.value(
            value: UserImageProvider.instance,
          ),
          ChangeNotifierProvider<AuthProvider>.value(
            value: AuthProvider.instance,
          )
        ],
        child: _registrationPageUI(),
      ),
    );
  }

  Widget _registrationPageUI() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: _deviceHeight * 0.75,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headingWidget(),
              _inputForm(),
              _registerButton(),
              _backToLoginPageButton(),
            ],
          ),
        ),
      ),
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
            "Let's get going!",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Please enter your details",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.40,
      child: Form(
        key: _formKey,
        onChanged: (){_formKey.currentState!.save();},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageSelectorWidget(),
            _nameTextField(),
            _emailTextField(),
            _passwordTextField()
          ],
        ),
      ),
    );
  }

  Widget _imageSelectorWidget() {
    return Builder(
      builder: (_context) {
        _userImageProvider = Provider.of<UserImageProvider>(_context);
        return Center(
          child: GestureDetector(
            onTap: () {
              UserImageProvider.instance.addUserImage();
            },
            child: _userImageProvider.status == UserImageStatus.Fetching
                ? CircularProgressIndicator()
                : Container(
                    alignment: Alignment.center,
                    height: _deviceHeight * 0.15,
                    width: _deviceWidth * 0.30,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(500),
                        image: _userImageProvider.status ==
                                UserImageStatus.Fetched
                            ? DecorationImage(
                                image: FileImage(_userImageProvider.userImage),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: NetworkImage(
                                    "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
                                fit: BoxFit.cover,
                              )),
                  ),
          ),
        );
      },
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.name,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        return value!.length != 0 ? null : "Please Enter a valid Email";
      },
      onSaved: (newValue) {
        setState(() {
          _name = newValue!;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Name",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
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
        setState(() {
          _email = newValue!;
        });
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
        setState(() {
          _password = newValue!;
        });
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

  Widget _registerButton() {
    return Builder(
      builder: (_context){
        _authProvider=Provider.of<AuthProvider>(_context);
        return _authProvider.status==AuthStatus.Authenticating?CircularProgressIndicator():Container(
          height: _deviceHeight * 0.06,
          width: _deviceWidth,
          child: MaterialButton(
            height: _deviceHeight * 0.06,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                AuthProvider.instance.registerUserWithEmailAndPassword(_email, _password,_name);
              }
            },
            color: Colors.blue,
            child: Text(
              "Register",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        );
      },
    );
  }

  Widget _backToLoginPageButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.goBack();
      },
      child: Container(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        child: Icon(
          Icons.arrow_back,
          size: 40,
        ),
      ),
    );
  }
}
