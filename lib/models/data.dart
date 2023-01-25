class Data {
  String? fullDateTime;
  String? photo;
  String? banner;
  String? text;

  Data(this.fullDateTime, this.photo, this.banner, this.text);

  // Map<String, dynamic> toJson() => {
  //   'name': name,
  //   'email': email,
  // };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['fullDateTime'] = fullDateTime;
    data['photo'] = photo;
    data['banner'] = banner;
    data['text'] = text;
    print(data);
    return data;
  }
}
