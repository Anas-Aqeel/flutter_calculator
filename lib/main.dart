// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic inpTxt = '';
  dynamic expTxt = '';
  dynamic result = 0;

  void calculation(val) {
    setState(() {
      if (val == 'C') {
        inpTxt = '';
        expTxt = '';
        result = 0;
      } else if (val == 'D') {
        if (inpTxt == '' || inpTxt == 0) {
          inpTxt = "0";
        } else {
          inpTxt = inpTxt.substring(0, inpTxt.length - 1);
        }
      } else if (val == '=') {
        expTxt = inpTxt;
        expTxt = expTxt.replaceAll('x', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expTxt);
          ContextModel cm = ContextModel();
          result = exp.evaluate(EvaluationType.REAL, cm);
          inpTxt = '0';
          expTxt = '0';
        } catch (e) {
          // debugPrint(e);
          result = '0';
          inpTxt = 'Error';
          expTxt = '0';
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              result = '0';
              inpTxt = '0';
              expTxt = '0';
            });
          });
        }
      } else {
        if (inpTxt == '0') {
          inpTxt = val;
        } else {
          inpTxt += val;
        }
      }
    });
  }

  Widget buildBtn(txt) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      child: NeumorphicButton(
        style: NeumorphicStyle(
            depth: 6,
            intensity: .7,
            surfaceIntensity: 0.4,
            boxShape: NeumorphicBoxShape.circle(),
            shape: NeumorphicShape.concave,
            lightSource: LightSource.topLeft,
            color: Colors.white,
            shadowDarkColor: Colors.grey,
            shadowLightColorEmboss: Colors.grey,
            disableDepth: false),
        child: Text(
          "$txt",
          style: TextStyle(fontSize: 30.0),
        ),
        onPressed: () {
          calculation(txt);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 270,
                child: Neumorphic(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8.0),
                  style: NeumorphicStyle(
                      depth: 6,
                      intensity: .7,
                      surfaceIntensity: 0.4,
                      shape: NeumorphicShape.concave,
                      lightSource: LightSource.topLeft,
                      color: Colors.white,
                      shadowDarkColor: Colors.grey,
                      shadowLightColorEmboss: Colors.grey,
                      disableDepth: false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text("$inpTxt",
                            maxLines: 1,
                            style: GoogleFonts.montserrat(fontSize: 35.0)),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text("$result",
                            style: GoogleFonts.montserrat(
                                fontSize: 30.0, color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 320,
                width: 270,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      depth: 6,
                      intensity: .7,
                      surfaceIntensity: .3,
                      shape: NeumorphicShape.concave,
                      lightSource: LightSource.topLeft,
                      color: Colors.white,
                      shadowDarkColor: Colors.grey,
                      shadowLightColorEmboss: Colors.grey,
                      disableDepth: false),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildBtn('('),
                          buildBtn(')'),
                          buildBtn('D'),
                          buildBtn('C'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildBtn("7"),
                          buildBtn('8'),
                          buildBtn('9'),
                          buildBtn('x'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildBtn('4'),
                          buildBtn('5'),
                          buildBtn('6'),
                          buildBtn('/'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildBtn('1'),
                          buildBtn('2'),
                          buildBtn('3'),
                          buildBtn('+'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildBtn('0'),
                          buildBtn('.'),
                          buildBtn('='),
                          buildBtn('-'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
