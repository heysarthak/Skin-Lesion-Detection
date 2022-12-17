import 'package:detect/screens/home.dart';
import 'package:detect/screens/profile.dart';
import 'package:detect/screens/upload-photo.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  late Widget _selectedWidget;

  @override
  void initState() {
    _selectedWidget = const HomeScreen();
    super.initState();
  }

  handleTakePhoto() async {
    Navigator.pop(context);

    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 675, maxWidth: 960);
    if (file != null)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => UploadPhotoScreen(image: file))));
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    print(Get.arguments.toString());
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 675, maxWidth: 960);
    if (file != null)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => UploadPhotoScreen(
                    image: file,
                  ))));
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Upload image"),
            backgroundColor: Colors.white,
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedWidget,
      bottomNavigationBar: DiamondBottomNavigation(
        itemIcons: const [
          Icons.home,
          Icons.person,
          Icons.question_answer,
          Icons.info,
        ],
        centerIcon: Icons.camera_alt_rounded,
        selectedIndex: _selectedIndex,
        onItemPressed: onPressed,
        selectedColor: Colors.teal.shade300,
        selectedLightColor: Colors.tealAccent,
      ),
    );
  }

  void onPressed(index) {
    print("Index number $index is pressed");
    if (index == 2) {
      print("Opening camera");
      selectImage(context);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: ((context) => UploadPhotoScreen())));
    } else
      setState(() {
        _selectedIndex = index;
        if (index == 0) {
          _selectedWidget = const HomeScreen();
        } else if (index == 1) {
          _selectedWidget = const ProfileScreen();
        } else if (index == 3) {
          _selectedWidget = Container();
        } else if (index == 4) {
          _selectedWidget = Container();
        }
      });
  }
}
