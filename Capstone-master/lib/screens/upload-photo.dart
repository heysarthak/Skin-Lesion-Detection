import 'dart:ffi';
import 'dart:io';

import 'package:detect/screens/results.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import '../models/pair.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key, required this.image});
  final XFile image;
  // final String email;
  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
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

  Future<Pair<String, int>> processImage() async {
    print("Processing image started");
    ImageProcessor imageProcessor = ImageProcessorBuilder()
        .add(ResizeOp(64, 64, ResizeMethod.BILINEAR))
        .build();

    TensorImage tensorImage = TensorImage.fromFile(File(widget.image.path));
    tensorImage = imageProcessor.process(tensorImage);

    var temp = tensorImage.buffer
        .asUint8List()
        .map((e) => double.parse(e.toString()))
        .toList();

    var inputBuffer = Float32List.fromList(temp).reshape([1, 64, 64, 3]);

    TensorBuffer probabilityBuffer =
        TensorBuffer.createFixedSize(<int>[1, 7], TfLiteType.float32);

    try {
      Interpreter interpreter = await Interpreter.fromAsset("model.tflite");

      interpreter.run(inputBuffer, probabilityBuffer.buffer);
    } catch (e) {
      print('Error loading model: ' + e.toString());
    }

    var results =
        probabilityBuffer.buffer.asFloat32List().map((e) => e.round()).toList();

    var index = results.indexOf(1);

    var labels = [
      Pair("Actinic_keratoses", 1),
      Pair("Basal_cell_carcinoma", 1),
      Pair("Benign_keratosis-like_lesions", 0),
      Pair("Dermatofibroma", 0),
      Pair("Melanocytic_nevi", 0),
      Pair("Vascular_lesions", 0),
      Pair("melanoma", 1),
    ];

    return labels[index];
  }

  bool isLoading = false;

  Future<void> detectCancer() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));
    var answer = await processImage();

    print([answer.a, answer.b]);
    // print(widget.email.toString());
    setState(() {
      isLoading = false;
    });

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ResultScreen(image: widget.image, result: answer)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF010101),
        elevation: 0,
        centerTitle: false,
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
                color: Colors.grey.shade100,
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
                      'Upload photo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF010101),
                          fontSize: 30,
                          fontFamily: 'Roboto'),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                height: 300,
                                width: 300,
                                alignment: Alignment.center,
                                child: Image.file(
                                  File(widget.image.path),
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              isLoading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color(0xFF010101)))
                                  : buttonDisp("Detect", detectCancer,
                                      Color(0xFFD9C1FF)),
                              SizedBox(
                                height: 10,
                              ),
                              buttonDisp("Cancel", () {
                                Navigator.pop(context);
                              }, Color(0xFF86D8CF))
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
