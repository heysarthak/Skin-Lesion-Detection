import 'dart:io';
// import 'dart:typed_data';
import 'package:detect/login.dart';
import 'package:detect/trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class OldHomeScreen extends StatefulWidget {
  OldHomeScreen({super.key});
  @override
  State<OldHomeScreen> createState() => _OldHomeScreenState();
}

class _OldHomeScreenState extends State<OldHomeScreen> {
  XFile? fileT;
  handleTakePhoto() async {
    Navigator.pop(context);
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 675, maxWidth: 960);
    setState(() {
      this.fileT = file;
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 675, maxWidth: 960);
    setState(() {
      this.fileT = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Upload image"),
            children: <Widget>[
              SimpleDialogOption(
                child: const Text("Photo with camera"),
                onPressed: () => handleTakePhoto(),
              ),
              SimpleDialogOption(
                child: const Text("Image from Gallery"),
                onPressed: () => handleChooseFromGallery(),
              ),
              SimpleDialogOption(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    print("loaded");
    super.initState();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text(
        "Logout",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      },
    );
    Widget cancel = ElevatedButton(
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure :)"),
      actions: [cancel, okButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(250, 249, 246, 1),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Icon(Icons.person)),
            )
          ],
          title: Text(
            "Detect.io",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.file_copy),
        //   onPressed: () {
        //     selectImage(context);
        //   },
        // ),
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey $name !!",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            // fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Welcome to your Personal Skin Lab",
                        maxLines: 2,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 55,
                ),
                imageDisplayer(),
              ],
            ),
          ],
        ));
  }
  // detect()async{
  //    Future.delayed(Duration.zero, () async {
  //     String? res = await Tflite.loadModel(
  //         model: "assets/model.tflite",
  //         // labels: "assets/labels.txt",
  //         numThreads: 1, // defaults to 1
  //         isAsset:
  //             true, // defaults to true, set to false to load resources outside assets
  //         useGpuDelegate:
  //             false // defaults to false, set to true to use GPU delegate
  //         );
  //   });

  // Image x = imgTransformer(fileT!);
  //  var recognitions = await Tflite.runModelOnImage(
  //   path: x,
  //   numResults: 6,
  //   threshold: 0.05,
  //   imageMean: 127.5,
  //   imageStd: 127.5,
  // );
  // }
  // Uint8List imageToByteListFloat32(
  //     img.Image image, int inputSize, double mean, double std) {
  //   var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  //   var buffer = Float32List.view(convertedBytes.buffer);
  //   int pixelIndex = 0;
  //   for (var i = 0; i < inputSize; i++) {
  //     for (var j = 0; j < inputSize; j++) {
  //       var pixel = image.getPixel(j, i);
  //       buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
  //       buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
  //       buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
  //     }
  //   }
  //   return convertedBytes.buffer.asUint8List();
  // }

  // Future recognizeImageBinary(File image) async {
  //   int startTime = new DateTime.now().millisecondsSinceEpoch;
  //   var imageBytes = (await rootBundle.load(image.path)).buffer;
  //   img.Image oriImage = img.decodeJpg(imageBytes.asUint8List())!;
  //   img.Image resizedImage = img.copyResize(oriImage, height: 224, width: 224);
  //   var recognitions = await Tflite.runModelOnBinary(
  //     binary: imageToByteListFloat32(resizedImage, 64, 1, 1),
  //     numResults: 6,
  //     threshold: 0.05,
  //   );
  //   print(recognitions);
  //   setState(() {
  //     // _recognitions = recognitions;
  //   });
  //   int endTime = new DateTime.now().millisecondsSinceEpoch;
  //   print("Inference took ${endTime - startTime}ms");
  // }

  imageDisplayer() {
    if (fileT == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  // height: 300,
                  width: 300,
                  // color: Colors.amber,
                  child: Image.asset(
                    "assets/doctor.png",
                  ),
                ),
                buttonDisp(
                    "Select Image", () => selectImage(context), Colors.purple),
                // buttonDisp("Choose From Gallery", handleChooseFromGallery,
                //     Colors.white),
              ],
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.file(
              File(fileT!.path),
              height: 300,
              width: 300,
            ),
          ),
          buttonDisp("Detect", () {}, Colors.purple),
          buttonDisp("Remove Image", () {
            fileT = null;
            setState(() {});
          }, Colors.red)
        ],
      );
    }
  }

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
}
