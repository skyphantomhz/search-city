class Forecasts {
  String day;
  int date;
  int low;
  int high;
  String text;
  int code;

  Forecasts({this.day, this.date, this.low, this.high, this.text, this.code});

  Forecasts.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    low = json['low'];
    high = json['high'];
    text = json['text'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['date'] = this.date;
    data['low'] = this.low;
    data['high'] = this.high;
    data['text'] = this.text;
    data['code'] = this.code;
    return data;
  }
}