import 'package:search_city/model/weather/current_observation.dart';
import 'package:search_city/model/weather/forecasts.dart';
import 'package:search_city/model/weather/location.dart';

class Weather {
  Location location;
  CurrentObservation currentObservation;
  List<Forecasts> forecasts;

  Weather({this.location, this.currentObservation, this.forecasts});

  Weather.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    currentObservation = json['current_observation'] != null
        ? new CurrentObservation.fromJson(json['current_observation'])
        : null;
    if (json['forecasts'] != null) {
      forecasts = new List<Forecasts>();
      json['forecasts'].forEach((v) {
        forecasts.add(new Forecasts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.currentObservation != null) {
      data['current_observation'] = this.currentObservation.toJson();
    }
    if (this.forecasts != null) {
      data['forecasts'] = this.forecasts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}