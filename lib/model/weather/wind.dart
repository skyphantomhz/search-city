class Wind {
  int chill;
  int direction;
  double speed;

  Wind({this.chill, this.direction, this.speed});

  Wind.fromJson(Map<String, dynamic> json) {
    chill = json['chill'];
    direction = json['direction'];
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chill'] = this.chill;
    data['direction'] = this.direction;
    data['speed'] = this.speed;
    return data;
  }
}