import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translate/utilities/utility.dart';
import 'package:translator/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_handle.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with SingleTickerProviderStateMixin {
  TextEditingController myController;
  TabController myTabController;
  GoogleTranslator translator;
  String transText = "";
  bool isGetting = false;
  final storage = FileStorage();
  List<String> lines = [];

  Widget getWidget() {
    if (isGetting && myController.text != null) {
      return LinearProgressIndicator(backgroundColor: Colors.yellow[400]);
    }
    if (!isGetting && myController.text == null) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Translated to ${codeLang.keys.firstWhere((k) => codeLang[k] == setLang, orElse: () => null)}",
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.black54,
              ),
            ),
            Material(
              color: Colors.yellow[700],
              elevation: 4.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Text(
                  transText == null ? "\"write some text\"" : transText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_string_key';
    var myString = prefs.getString(key) ?? 'no data';
    if (myString == 'no data') {
      await showModalBottomSheet(
          context: context, builder: (context) => AddTaskScreen());
      myString = prefs.getString(key) ?? 'no data';
      setLang = myString;
    } else {
      setLang = myString;
    }
  }

  FloatingActionButton getFAB(){
    if(myTabController.index==0){
      return FloatingActionButton.extended(
        label: Text(
          "Translate",
          style: GoogleFonts.aBeeZee(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Colors.yellow[800],
        icon: Icon(Icons.translate),
        onPressed: () async {
          setState(() {
            isGetting = true;
          });
          if (myController.text != "") {
            final String enteredText = myController.text;
            storage.writeFile(" " + enteredText);
            lines.add(enteredText);
          }
          String temp = await getTranslatedText(myController.text);
          setState(() {
            FocusScope.of(context).requestFocus(new FocusNode());
            transText = temp;
            isGetting = false;
            myTabController.animateTo(0);
          });
        },
      );
    }
    else if(myTabController.index==1){
      return FloatingActionButton.extended(
        onPressed: (){
          storage.clearFile();
          lines.clear();
          setState(() {
            myTabController.animateTo(0);
          });
        },
        icon: Icon(Icons.clear, size: 30,),
        label: Text("Clear",
          style: GoogleFonts.aBeeZee(fontSize: 17),),
      );
    }
  }

  String setLang;

  getTranslatedText(String s) async {
    isGetting = true;
    var tempTransText = s;
    if (s != "") tempTransText = await translator.translate(s, to: setLang);
    tempTransText.toString();
    return tempTransText;
  }

  _loadFile() async {
    final String readLines = await storage.readFileAsString();
    lines = readLines.split(" ");
    setState(() {
      //Escape the new line
    });
  }
  @override
  void initState() {
    _read();
    myTabController = TabController(vsync: this, length: 2)
      ..addListener(() {
        print(myTabController.index);
        setState(() {

        });
      });
    myController = TextEditingController();
    translator = GoogleTranslator();
    _loadFile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: getFAB() ,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.yellow[800],
          title: Text(
            "Translator",
            style: GoogleFonts.lobster(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            Center(
                child: Text("Change\nLanguage",
                    style: TextStyle(color: Colors.yellow))),
            IconButton(
              icon: Icon(
                Icons.blur_on,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () async {
                await showModalBottomSheet(
                    context: context, builder: (context) => AddTaskScreen());
                await _read();
                String temp = await getTranslatedText(myController.text);
                setState(() {
                  transText = temp;
                  isGetting = false;
                });
              },
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("Translate"),
              ),
              Tab(
                child: Text("History"),
              ),
            ],
            indicatorColor: Colors.white,
            controller: myTabController,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow[800])),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    controller: myController,
                  ),
                ),
                getWidget(),
              ],
            ),
            ListView.builder(
                itemCount: lines.length,
                itemBuilder: (context, index) {
                  if (index == lines.length - 1) {
                    return null;
                  }
                  return FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      elevation: 5,
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 500,
                          child: Center(
                            child: Text(
                              lines[index + 1],
                              style: GoogleFonts.lobster(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        myController.text = lines[index + 1];
                      });
                      String temp = await getTranslatedText(myController.text);
                      setState(() {
                        myTabController.animateTo(0);
                        FocusScope.of(context).requestFocus(new FocusNode());
                        transText = temp;
                        isGetting = false;
                      });
                    },
                  );
                }),
          ],
          controller: myTabController,
        ),
      ),
    );
  }
}
