class Atmosphere {
  int humidity;
  double visibility;
  double pressure;
  int rising;

  Atmosphere({this.humidity, this.visibility, this.pressure, this.rising});

  Atmosphere.fromJson(Map<String, dynamic> json) {
    humidity = json['humidity'];
    visibility = json['visibility'];
    pressure = json['pressure'];
    rising = json['rising'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['humidity'] = this.humidity;
    data['visibility'] = this.visibility;
    data['pressure'] = this.pressure;
    data['rising'] = this.rising;
    return data;
  }
}