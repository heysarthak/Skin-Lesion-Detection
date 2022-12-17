import 'package:flutter/material.dart';

import 'home.dart';

class FormDetails extends StatefulWidget {
  const FormDetails({super.key});

  @override
  State<FormDetails> createState() => _FormDetailsState();
}

class _FormDetailsState extends State<FormDetails> {
  late TextEditingController _c;
  @override
  void initState() {
    // TODO: implement initState
    _c = TextEditingController();
    super.initState();
  }

  String select = "Male";

  Widget radioSelection() {
    List gender = ["Male", "Female", "Other"];

    Row addRadioButton(int btnValue, String title) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            activeColor: Colors.purple,
            value: gender[btnValue],
            groupValue: select,
            onChanged: (value) {
              setState(() {
                print(value);
                select = value;
                // btnValue = 1;
              });
            },
          ),
          Text(title)
        ],
      );
    }

    //Use the above widget where you want the radio button
    return Row(
      children: <Widget>[
        addRadioButton(0, 'Male'),
        addRadioButton(1, 'Female'),
        addRadioButton(2, 'Others'),
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fill Details to Continue")),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15),
                      child: TextField(
                        controller: _c,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15),
                      // padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Age',
                        ),
                      ),
                    ),
                    radioSelection(),
                    SizedBox(
                      height: 30,
                    ),
                    buttonDisp(
                        "Submit",
                        () => {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => OldHomeScreen(),
                              ))
                            },
                        Colors.purple)
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
