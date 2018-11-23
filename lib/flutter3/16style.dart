import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Transform(
              transform: Matrix4.skewY(0.3)..rotateZ(-math.pi / 12.0),
              child: Container(
                width: 280.0,
                height: 280.0,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: <Color>[
                      Color(0xffef5350),
                      Color(0x00ef5350),
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xcc000000),
                      offset: Offset(10.0, 2.0),
                      blurRadius: 4.0,
                    ),
                    BoxShadow(
                      color: Color(0x80000000),
                      offset: Offset(5.0, 6.0),
                      blurRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(1000.0),
                  // border: Border.all(
                  //  color: Colors.black,)
                  shape: BoxShape.rectangle,
                ),
                alignment: Alignment.centerLeft,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.0,
                    ),
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w100,
                        ),
                        text: "Styling Widgets",
                      ),
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontWeight: FontWeight.w900,
                        ),
                        text: "Stuff In Flutter",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
