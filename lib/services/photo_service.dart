import 'dart:convert';

import 'package:fotobudka/models/data.dart';
import 'package:http/http.dart' as http;

class PhotoService {
  sendPhoto(Data data) async {
    try {
      await http.post(
        Uri.parse('http://10.0.2.2:5231/data'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(data.toJson()),
      );
    } catch (exception) {
      print(exception);
    }
  }
}
