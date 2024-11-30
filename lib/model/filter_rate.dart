class FilterRates {
  bool? success;
  String? message;
  List<Data>? data;

  FilterRates({this.success, this.message, this.data});

  FilterRates.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? state;
  String? district;
  String? market;
  String? commodity;
  String? variety;
  String? grade;
  String? arrivalDate;
  String? minX0020Price;
  String? maxX0020Price;
  String? modalX0020Price;
  dynamic createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.state,
    this.district,
    this.market,
    this.commodity,
    this.variety,
    this.grade,
    this.arrivalDate,
    this.minX0020Price,
    this.maxX0020Price,
    this.modalX0020Price,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    district = json['district'];
    market = json['market'];
    commodity = json['commodity'];
    variety = json['variety'];
    grade = json['grade'];
    arrivalDate = json['arrival_date'];
    minX0020Price = json['min_x0020_price'];
    maxX0020Price = json['max_x0020_price'];
    modalX0020Price = json['modal_x0020_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['district'] = this.district;
    data['market'] = this.market;
    data['commodity'] = this.commodity;
    data['variety'] = this.variety;
    data['grade'] = this.grade;
    data['arrival_date'] = this.arrivalDate;
    data['min_x0020_price'] = this.minX0020Price;
    data['max_x0020_price'] = this.maxX0020Price;
    data['modal_x0020_price'] = this.modalX0020Price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
