import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryTile extends StatelessWidget {
  final String tileText;
  HistoryTile({this.tileText});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Card(
            elevation: 5,
            child: Container(
              height: 50,
              width: 500,
              child: Center(
                child: Text(tileText,style: GoogleFonts.lobster(fontSize: 20),),
              ),
            ),
          ),
          onPressed: () {},
        ),

      ],
    );
  }
}
