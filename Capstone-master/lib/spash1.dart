import 'package:detect/home.dart';
import 'package:detect/splash4.dart';
import 'package:detect/textstyles.dart';
import 'package:flutter/material.dart';

class Spash1 extends StatelessWidget {
  const Spash1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 0,
          ),
          // SizedBox(
          //   height: 0,
          // ),
          // SizedBox(
          //   height: 0,
          // ),
          Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Image.asset('assets/doctor.png')),
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 20, bottom: 5),
                child: Text(
                  "1000K+ Downloads",
                  style: textStyleSpash(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                child: Text(
                  "gg wp this is my appgg wp this is my appgg wp this is my appgg wp this is my app",
                  style: textStyleSpash().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: (() {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: ((context) => Spash4())));
            }),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  )),
              child: Text(
                "NEXT",
                style: TextStyle(
                    color: Colors.white,
                    // fontStyle: FontStyle.italic,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
