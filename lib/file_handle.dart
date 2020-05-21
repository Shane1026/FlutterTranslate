import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/file.txt');
  }

  Future<String> readFileAsString() async {
    String contents = "";
    final file = await _localFile;
    if (file.existsSync()) { //Must check or error is thrown

      contents = await file.readAsString();
    }
    return contents;
  }

  Future<Null> writeFile(String text) async {
    final file = await _localFile;
    IOSink sink = file.openWrite(mode: FileMode.append);
    sink.add(utf8.encode('$text\n')); //Use newline as the delimiter
    await sink.flush();
    await sink.close();
  }
  Future<Null> clearFile() async {
    final file = await _localFile;
    await file.writeAsString(null);
    print("cleared");
  }
}