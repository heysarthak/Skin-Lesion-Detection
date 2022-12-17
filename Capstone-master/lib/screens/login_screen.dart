import 'package:detect/controllers/authentication_repository.dart';
import 'package:detect/controllers/signup_controller.dart';
import 'package:detect/main.dart';
import 'package:detect/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(SignupController());
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        color: Color(0xFF010101),
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(
            "assets/images/logo.jpeg",
            height: size.height * 0.2,
          ),
          Text(
            "Welcome Back!",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "To your personal skin lab.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Form(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.email,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                        color: Color(0xFF86D8CF),
                      ),
                      labelText: "E-mail",
                      labelStyle: TextStyle(color: Color(0xFF86D8CF)),
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Color(0xFF86D8CF)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFF86D8CF),
                        width: 2.0,
                      )),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF86D8CF), width: 2.0))),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: controller.password,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFF86D8CF),
                        width: 2.0,
                      )),
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                        color: Color(0xFF86D8CF),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Color(0xFF86D8CF)),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Color(0xFF86D8CF)),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF86D8CF))),
                      suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.remove_red_eye_sharp),
                        color: Color(0xFF86D8CF),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text.rich(TextSpan(
                            text: "Forgot Password?",
                            style: TextStyle(color: Color(0xFF86D8CF)))))),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          AuthenticationRepository.instance
                              .loginUserWithEmailAndPassword(
                                  controller.email.text.trim(),
                                  controller.password.text.trim());
                        },
                        child: Text("LOGIN")))
              ],
            ),
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("OR"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Image.asset(
                    "assets/images/google.png",
                    width: 20.0,
                  ),
                  onPressed: () {},
                  label: Text("Sign in with Google"),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: Text.rich(TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(color: Colors.white),
                      children: const [
                        TextSpan(
                          text: "Signup",
                          style: TextStyle(color: Color(0xFF86D8CF)),
                        )
                      ]))),
            ],
          )
        ]),
      ))),
    );
  }
}
