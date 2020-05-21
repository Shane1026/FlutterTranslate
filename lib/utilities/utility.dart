import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

_save(String ch) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'my_string_key';
  final value = ch;
  prefs.setString(key, value);
  print('saved $value');
}

var selectedDropDownItem;

CupertinoTheme getiOSPicker(BuildContext context) {
  List<Text> theList = [];
  for (String currentItem in codeLang.keys) {
    var newItem = Text(currentItem);
    theList.add(newItem);
  }

  return CupertinoTheme(
    data: CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        pickerTextStyle: TextStyle(
          color: Colors.red,
          fontSize: 18.0,
        ),
      ),
    ),
    child: CupertinoPicker(

      children: theList,
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedItem) async {

        selectedDropDownItem = selectedItem;
        selectedDropDownItem = codeLang[theList[selectedDropDownItem].data];

      },
    ),
  );
}

const codeLang = {
  'Arabic': 'ar',
  'Basque': 'eu',
  'Bengali': 'bn',
  'Bulgarian': 'bg',
  'Chinese (China)': 'zh-CN',
  'Chinese (Taiwan)': 'zh-TW',
  'Catalan': 'ca',
  'Croatian': 'hr',
  'Czech': 'cs',
  'Danish': 'da',
  'Dutch': 'nl',
  'English': 'en',
  'Estonian': 'et',
  'Finnish': 'fi',
  'French': 'fr',
  'German': 'de',
  'Greek': 'el',
  'Gujarati': 'gu',
  'Hebrew': 'iw',
  'Hindi': 'hi',
  'Hungarian': 'hu',
  'Icelandic': 'is',
  'Indonesian': 'id',
  'Italian': 'it',
  'Japanese': 'ja',
  'Kannada': 'kn',
  'Korean': 'ko',
  'Latvian': 'lv',
  'Lithuanian': 'lt',
  'Malay': 'ms',
  'Malayalam': 'ml',
  'Marathi': 'mr',
  'Norwegian': 'no',
  'Polish': 'pl',
  'Romanian': 'ro',
  'Russian': 'ru',
  'Slovak': 'sk',
  'Slovenian': 'sl',
  'Spanish': 'es',
  'Swahili': 'sw',
  'Swedish': 'sv',
  'Tamil': 'ta',
  'Telugu': 'te',
  'Thai': 'th',
  'Turkish': 'tr',
  'Urdu': 'ur',
  'Ukrainian': 'uk',
  'Vietnamese': 'vi',
  'Welsh': 'cy',
};

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Select the language you know",
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              height: 130.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 5.0),
              child: getiOSPicker(context),
            ),
            Center(
              child: Container(
                width: 100,
                color: Colors.white,
                child: FlatButton(
                  child: Text(
                    "OK",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () async {
                    await _save(selectedDropDownItem);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
