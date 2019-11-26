import 'package:search_city/model/base_model.dart';

class BaseResponse<T extends BaseModel> {
  String status;
  T data;

  BaseResponse({this.status, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? fromJson(json['data'], T) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}