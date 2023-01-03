import 'package:fotobudka/models/data.dart';
import 'package:http/http.dart' as http;

class PhotoService {
  sendPhoto(Data data) async {
    var url = Uri.http('10.0.2.2:5231', '/data');
    var dataToSend = data.toJson();
    var response = await http.post(url, body: dataToSend);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

