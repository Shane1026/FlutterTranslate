import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:translate/page_1.dart';

class OpenScreen extends StatefulWidget {
  @override
  _OpenScreenState createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.black, end: Colors.red[900])
        .animate(controller);
    controller.reverse(from: 1);
    controller.addStatusListener((status) {
      setState(() {
        // ignore: unrelated_type_equality_checks
        if (animation.value == Color(0xffb71c1c))
          controller.reverse();
        else if (animation.value == Color(0xff000000)) controller.forward();
      });
    });
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/translate-icons.png'),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Translator",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lobster(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[800],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: 600,
              color: Colors.yellow[800],
              child: FlatButton(
                child: Text(
                  "Let's Translate",
                  style: GoogleFonts.lobster(
                    fontSize: 25,
                    color: animation.value,
                  ),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Page1(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
