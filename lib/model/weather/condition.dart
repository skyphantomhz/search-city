class Condition {
  String text;
  int code;
  int temperature;

  Condition({this.text, this.code, this.temperature});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    code = json['code'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['code'] = this.code;
    data['temperature'] = this.temperature;
    return data;
  }
}