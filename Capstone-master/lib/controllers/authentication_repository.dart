import 'package:detect/controllers/signup_email_password_failure.dart';
import 'package:detect/screens/home.dart';
import 'package:detect/screens/login_screen.dart';
import 'package:detect/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    // TODO: implement onReady
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("email", user.email.toString());
    }

    user == null
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const Navbar(), arguments: user.email);
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(
              () => const Navbar(),
              arguments: email,
            )
          : Get.to(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print(ex.message);
    } catch (_) {}
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print(ex.message);
    } catch (_) {}
  }

  Future<void> logout() async => _auth.signOut();
}
