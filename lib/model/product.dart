class Product {
  bool? success;
  List<Data>? data;

  Product({this.success, this.data});

  Product.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? commodityId;
  String? varietyId;
  String? quality;
  String? rate;
  String? quantity;
  String? unit;
  List<String>? image;
  String? state;
  String? district;
  String? description;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.commodityId,
        this.varietyId,
        this.quality,
        this.rate,
        this.quantity,
        this.unit,
        this.image,
        this.state,
        this.district,
        this.description,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    commodityId = json['commodity_id'];
    varietyId = json['variety_id'];
    quality = json['quality'];
    rate = json['rate'];
    quantity = json['quantity'];
    unit = json['unit'];
    image = json['image'].cast<String>();
    state = json['state'];
    district = json['district'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['commodity_id'] = this.commodityId;
    data['variety_id'] = this.varietyId;
    data['quality'] = this.quality;
    data['rate'] = this.rate;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['image'] = this.image;
    data['state'] = this.state;
    data['district'] = this.district;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
