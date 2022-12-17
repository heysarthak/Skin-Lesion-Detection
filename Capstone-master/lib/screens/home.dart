import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF010101),
          ),
          Positioned(
            top: -40,
            left: -50,
            child: Container(
              child: Image.asset(
                "assets/images/logo.jpeg",
                height: 260,
                gaplessPlayback: false,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Color(0xFFFFFFFF),
              ),
              height: MediaQuery.of(context).size.height * 3.5 / 5,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Early detection\nmakes a difference',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Roboto'),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFD9C1FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Our test can help you detect melanoma.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 22),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Image.asset(
                                      "assets/images/fingerprint.png",
                                      fit: BoxFit.contain,
                                      height: 60,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Id optio animi perspiciatis, in, et aspernatur eos rem iusto ea obcaecati ipsum ad quia conse"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "quuntur explicabo maxime asperiores, cum dolores laudantium suscipit molestiae voluptatem sapiente! Aspernatur blanditiis qui vel. Nesciunt a vel nemo ab eum praesentium provident numquam deleniti aliquam. Consectetur sit eligendi, aperiam quaerat a recusandae in esse sus"),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Text('Read more',
                                        style: TextStyle(
                                            color: Color(0xFF86D8CF),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Color(0xFF86D8CF),
                                    disabledForegroundColor:
                                        Colors.yellow.withOpacity(0.38),
                                    side: BorderSide(
                                        color: Color(0xFF86D8CF), width: 2),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                  ),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Row(
                              children: [
                                CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 5.0,
                                  percent: 1,
                                  center: new Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  progressColor: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      statRow(
                                          Colors.red, "Photos Uploaded", "0"),
                                      statRow(Colors.green, "Without problems",
                                          "0"),
                                      statRow(Colors.yellow,
                                          "Diagnosed problems", "0")
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row statRow(Color color, String text, String stat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                width: 10,
                height: 10,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: color)),
            SizedBox(
              width: 10,
            ),
            Text(text),
          ],
        ),
        Text(stat)
      ],
    );
  }
}
