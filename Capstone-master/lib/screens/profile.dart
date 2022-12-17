import 'package:detect/controllers/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      color: Color(0xFF010101),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.power_settings_new),
          color: Color(0xFFD9C1FF),
          iconSize: 200,
          onPressed: () {
            AuthenticationRepository.instance.logout();
          },
        ),
      ),
    ));
  }
}
