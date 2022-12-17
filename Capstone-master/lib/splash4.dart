import 'package:detect/home.dart';
import 'package:detect/login.dart';
import 'package:detect/textstyles.dart';
import 'package:flutter/material.dart';

class Spash4 extends StatelessWidget {
  const Spash4({super.key});

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.pink,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
          margin: EdgeInsets.all(0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                // top: 0,
                bottom: 0,
                // left: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  height: s.height / 3, width: s.width,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 8),
                        child: Text(
                          "gg wp this is my appgg wp this is my appgg wp this is my appgg wp this is my app",
                          style: textStyleSpash().copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => OldHomeScreen())));
                        }),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              )),
                          child: Text(
                            "NEXT",
                            style: TextStyle(
                                color: Colors.white,
                                // fontStyle: FontStyle.italic,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),

                  // height: MediaQuery.of(context).size.height / 3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
