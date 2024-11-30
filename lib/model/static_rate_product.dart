class StaticRateProduct {
  bool? success;
  List<Data>? data;

  StaticRateProduct({this.success, this.data});

  StaticRateProduct.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? commodity;
  String? state;
  String? district;
  String? market;
  String? price;
  String? minPrice;
  String? maxPrice;

  Data(
      {this.image,
        this.commodity,
        this.state,
        this.district,
        this.market,
        this.price,
        this.minPrice,
        this.maxPrice});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    commodity = json['commodity'];
    state = json['state'];
    district = json['district'];
    market = json['market'];
    price = json['price'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['commodity'] = this.commodity;
    data['state'] = this.state;
    data['district'] = this.district;
    data['market'] = this.market;
    data['price'] = this.price;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    return data;
  }
}
