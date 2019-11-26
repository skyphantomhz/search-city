import 'package:search_city/model/base_model.dart';

class City extends BaseModel {
  int woeid;
  double lat;
  double lon;
  String country;
  String city;
  String qualifiedName;

  City(
      {this.woeid,
      this.lat,
      this.lon,
      this.country,
      this.city,
      this.qualifiedName});

  City.fromJson(Map<String, dynamic> json) {
    woeid = json['woeid'];
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    city = json['city'];
    qualifiedName = json['qualifiedName'];
  }
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['woeid'] = this.woeid;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['country'] = this.country;
    data['city'] = this.city;
    data['qualifiedName'] = this.qualifiedName;
    return data;
  }
}
