import 'package:intl/intl.dart';

class Data {
  String? fullDateTime = DateTime.now().toString();
  String? photo;
  String? banner;
  String? text;

  Data(this.photo, this.banner, this.text);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddHms');
    final String formatted = formatter.format(now);
    print("*******************************************************");
    print(formatted);
    var formatedDateTimeNow = formatted;
    data['fullDateTime'] = formatedDateTimeNow;
    data['photo'] = photo ?? '';
    data['banner'] = banner ?? '';
    data['text'] = text ?? '';
    return data;
  }
}
