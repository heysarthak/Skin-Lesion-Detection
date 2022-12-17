import 'package:detect/controllers/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //TextField Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();

  //Call this function from Design & it
  void registerUser(String email, String password) {
    print(email);
    print(password);
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  void loginUser(String email, String password) {
    AuthenticationRepository.instance
        .loginUserWithEmailAndPassword(email, password);
  }
}
