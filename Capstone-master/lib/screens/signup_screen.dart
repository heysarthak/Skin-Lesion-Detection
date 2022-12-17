import 'package:detect/controllers/signup_controller.dart';

import 'package:detect/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(SignupController());
    // static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          color: Color(0xFF010101),
          padding: const EdgeInsets.all(30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(
              "assets/images/logo.jpeg",
              height: size.height * 0.2,
            ),
            Text("Get On Board!",
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            Text("To your personal skin lab!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Form(
                  // key: _formKey,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: controller.fullName,
                    decoration: InputDecoration(
                        label: Text("Full Name"),
                        prefix: Icon(
                          Icons.person_outline_rounded,
                          color: Color(0xFF86D8CF),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF86D8CF)),
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Color(0xFF86D8CF)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: Color(0xFF86D8CF))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xFFD9C1FF),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: controller.email,
                    decoration: InputDecoration(
                        label: Text("E-Mail"),
                        hintText: ("E-Mail"),
                        hintStyle: TextStyle(color: Color(0xFF86D8CF)),
                        prefix: Icon(
                          Icons.email_outlined,
                          color: Color(0xFF86D8CF),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF86D8CF)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xFFD9C1FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: Color(0xFF86D8CF)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: controller.password,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Color(0xFF86D8CF)),
                        prefix: Icon(
                          Icons.fingerprint,
                          color: Color(0xFF86D8CF),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF86D8CF)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xFFD9C1FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: Color(0xFF86D8CF)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFD9C1FF),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            SignupController.instance.registerUser(
                                controller.email.text.trim(),
                                controller.password.text.trim());
                          },
                          child: const Text("Signup"))),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      const Text("OR"),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/google.png",
                            width: 20.0,
                          ),
                          label: Text("Sign-in with Google"),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "Already have an account?  ",
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: "Login",
                                style: TextStyle(color: Color(0xFF86D8CF)))
                          ])))
                    ],
                  )
                ],
              )),
            )
          ]),
        )),
      ),
    );
  }
}
