class PurchaseRequest {
  bool? success;
  Data? data;

  PurchaseRequest({this.success, this.data});

  PurchaseRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Approved>? approved;
  List<Approved>? unapproved;
  List<Approved>? cancelled;
  List<Approved>? rejected;
  List<Approved>? delivered;

  Data({
    this.approved,
    this.unapproved,
    this.cancelled,
    this.rejected,
    this.delivered,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['approved'] != null) {
      approved = <Approved>[];
      json['approved'].forEach((v) {
        approved!.add(new Approved.fromJson(v));
      });
    }
    if (json['unapproved'] != null) {
      unapproved = <Approved>[];
      json['unapproved'].forEach((v) {
        unapproved!.add(new Approved.fromJson(v));
      });
    }
    if (json['cancelled'] != null) {
      cancelled = <Approved>[];
      json['cancelled'].forEach((v) {
        cancelled!.add(new Approved.fromJson(v));
      });
    }
    if (json['rejected'] != null) {
      rejected = <Approved>[];
      json['rejected'].forEach((v) {
        rejected!.add(new Approved.fromJson(v));
      });
    }
    if (json['delivered'] != null) {
      delivered = <Approved>[];
      json['delivered'].forEach((v) {
        delivered!.add(new Approved.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approved != null) {
      data['approved'] = this.approved!.map((v) => v.toJson()).toList();
    }
    if (this.unapproved != null) {
      data['unapproved'] = this.unapproved!.map((v) => v.toJson()).toList();
    }
    if (this.cancelled != null) {
      data['cancelled'] = this.cancelled!.map((v) => v.toJson()).toList();
    }
    if (this.rejected != null) {
      data['rejected'] = this.rejected!.map((v) => v.toJson()).toList();
    }
    if (this.delivered != null) {
      data['delivered'] = this.delivered!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Approved {
  int? id;
  String? userId;
  String? productId;
  String? sellerId;
  String? user;
  String? phone;
  String? commodity;
  String? variety;
  String? quality;
  List<String>? image;
  String? state;
  String? district;
  String? description;
  String? quantity;
  String? unit;
  String? pricePerQuantity;
  int? amount;
  String? createdAt;

  Approved(
      {this.id,
      this.userId,
      this.productId,
      this.sellerId,
      this.user,
      this.phone,
      this.commodity,
      this.variety,
      this.quality,
      this.image,
      this.state,
      this.district,
      this.description,
      this.quantity,
      this.unit,
      this.pricePerQuantity,
      this.amount,
      this.createdAt});

  Approved.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    sellerId = json['seller_id'];
    user = json['user'];
    phone = json['phone'];
    commodity = json['commodity'];
    variety = json['variety'];
    quality = json['quality'];
    image = json['image'].cast<String>();
    state = json['state'];
    district = json['district'];
    description = json['description'];
    quantity = json['quantity'];
    unit = json['unit'];
    pricePerQuantity = json['price_per_quantity'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['seller_id'] = this.sellerId;
    data['user'] = this.user;
    data['phone'] = this.phone;
    data['commodity'] = this.commodity;
    data['variety'] = this.variety;
    data['quality'] = this.quality;
    data['image'] = this.image;
    data['state'] = this.state;
    data['district'] = this.district;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['price_per_quantity'] = this.pricePerQuantity;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    return data;
  }
}
