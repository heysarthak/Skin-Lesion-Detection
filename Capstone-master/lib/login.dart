import 'package:detect/home.dart';
import 'package:detect/main.dart';
import 'package:flutter/material.dart';
import 'form.dart';
import 'home.dart';

import 'package:flutter_login/flutter_login.dart';

const users = const {
  'divjyot@gmail.com': 'helloworld',
  'hunter@gmail.com': 'hunter',
};
const userName = const {
  'divjyot@gmail.com': 'divjyot',
  'hunter@gmail.com': 'divesh',
};

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "";
  bool signup = false;
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async{
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      signup = true;
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Detect.io',
      // logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        if (signup) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => FormDetails(),
          ));
        } else {
          name = "Vividh";
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => OldHomeScreen(),
          ));
        }
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
