class Location {
  int woeid;
  String city;
  String region;
  String country;
  double lat;
  double long;
  String timezoneId;

  Location(
      {this.woeid,
      this.city,
      this.region,
      this.country,
      this.lat,
      this.long,
      this.timezoneId});

  Location.fromJson(Map<String, dynamic> json) {
    woeid = json['woeid'];
    city = json['city'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    long = json['long'];
    timezoneId = json['timezone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['woeid'] = this.woeid;
    data['city'] = this.city;
    data['region'] = this.region;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['timezone_id'] = this.timezoneId;
    return data;
  }
}