import 'package:search_city/model/weather/astronomy.dart';
import 'package:search_city/model/weather/atmosphere.dart';
import 'package:search_city/model/weather/condition.dart';
import 'package:search_city/model/weather/wind.dart';

class CurrentObservation {
  Wind wind;
  Atmosphere atmosphere;
  Astronomy astronomy;
  Condition condition;
  int pubDate;

  CurrentObservation(
      {this.wind,
      this.atmosphere,
      this.astronomy,
      this.condition,
      this.pubDate});

  CurrentObservation.fromJson(Map<String, dynamic> json) {
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    atmosphere = json['atmosphere'] != null
        ? new Atmosphere.fromJson(json['atmosphere'])
        : null;
    astronomy = json['astronomy'] != null
        ? new Astronomy.fromJson(json['astronomy'])
        : null;
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    pubDate = json['pubDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    if (this.atmosphere != null) {
      data['atmosphere'] = this.atmosphere.toJson();
    }
    if (this.astronomy != null) {
      data['astronomy'] = this.astronomy.toJson();
    }
    if (this.condition != null) {
      data['condition'] = this.condition.toJson();
    }
    data['pubDate'] = this.pubDate;
    return data;
  }
}