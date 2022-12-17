import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detect/controllers/signup_controller.dart';
import 'package:detect/screens/navbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import '../models/pair.dart';

bool isLoading = false;
Future uploadImageResult(String image_path, String result1, int result2) async {
  ////
  print(result1);
  print(result2);

  String imageURL = '';
  String uniquename = DateTime.now().millisecondsSinceEpoch.toString();
  FirebaseStorage storageRef = FirebaseStorage.instance;
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('detection_results');
  Reference ref = storageRef.ref().child("images");
  Reference refImage = ref.child(uniquename);
  try {
    await refImage.putFile(File(image_path));
    imageURL = await refImage.getDownloadURL();
    final prefs = await SharedPreferences.getInstance();

    final String? email = prefs.getString("email");
    print(imageURL);
    print(email);

    String type = result2 == 1 ? "Malignant" : "Benign";
    Map<String, String> imageResultUpload = {
      'type': type,
      'disease': result1,
      'image': imageURL,
      'email': email.toString(),
    };
    _reference.add(imageResultUpload);
  } catch (e) {
    print(e);
  }
}

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.image, required this.result});
  final XFile image;
  final Pair<String, int> result;
  final imageURL = '';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final controller = Get.put(SignupController());
  Widget buttonDisp(String s, Function() param1, Color c) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
          onPressed: param1,
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              backgroundColor: c,
              side: (c != Colors.white)
                  ? null
                  : BorderSide(color: Colors.purple)),
          child: Text(
            s,
            style: TextStyle(
                color: (c != Colors.white) ? Colors.white : Colors.purple,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Transform(
          transform: Matrix4.translationValues(250.0, 0.0, 0.0),
          child: Image.asset(
            "assets/images/logo.jpeg",
            height: 80,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF010101),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 7 / 8,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Detection Results',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF010101),
                          fontSize: 20,
                          fontFamily: 'Roboto'),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  alignment: Alignment.center,
                                  child: Image.file(
                                    File(widget.image.path),
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Risk assesment: ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: (widget.result.b == 1
                                          ? 'The type of cancer detected is malignant.'
                                          : 'The type of cancer detected is benign.'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Result: ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: '(43%) ' +
                                          (widget.result.b == 1
                                              ? 'Malignant'
                                              : 'Benign' + ' lesions'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Diagnosis: ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: widget.result.a,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Advice: ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: 'Talk to a dermatoligist',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Color(0xFF010101)))
                                    : buttonDisp("Save Result", () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await Future.delayed(
                                            Duration(seconds: 2));
                                        uploadImageResult(widget.image.path,
                                            widget.result.a, widget.result.b);
                                        const snackBar = SnackBar(
                                          content: Text(
                                            'Results upload successful!',
                                            style: TextStyle(
                                                color: Color(0xFFD9C1FF)),
                                          ),
                                          backgroundColor: Color(0xFF010101),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Navbar()));
                                      }, Color(0xFFD9C1FF)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: buttonDisp("Cancel", () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Navbar()));
                                }, Color(0xFF86D8CF)),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
