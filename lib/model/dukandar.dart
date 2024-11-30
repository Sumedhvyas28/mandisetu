class Dukandar {
  bool? success;
  List<Data>? data;

  Dukandar({this.success, this.data});

  Dukandar.fromJson(Map<String, dynamic> json) {
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
  String? mandivyapariId;
  String? name;
  String? phone;
  String? shopName;
  String? address;
  dynamic email;
  dynamic mandiLicense;
  dynamic gumasta;
  dynamic gstRegistration;
  dynamic mandiLicenseNo;
  dynamic gumastaNo;
  dynamic gstNo;
  dynamic aadhar;
  dynamic pan;
  dynamic aadharCard;
  dynamic panCard;
  dynamic accountNo;
  dynamic ifscCode;
  dynamic statement;
  dynamic officePhn;
  dynamic image;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.mandivyapariId,
        this.name,
        this.phone,
        this.shopName,
        this.address,
        this.email,
        this.mandiLicense,
        this.gumasta,
        this.gstRegistration,
        this.mandiLicenseNo,
        this.gumastaNo,
        this.gstNo,
        this.aadhar,
        this.pan,
        this.aadharCard,
        this.panCard,
        this.accountNo,
        this.ifscCode,
        this.statement,
        this.officePhn,
        this.image,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mandivyapariId = json['mandivyapari_id'];
    name = json['name'];
    phone = json['phone'];
    shopName = json['shop_name'];
    address = json['address'];
    email = json['email'];
    mandiLicense = json['mandi_license'];
    gumasta = json['gumasta'];
    gstRegistration = json['gst_registration'];
    mandiLicenseNo = json['mandi_license_no'];
    gumastaNo = json['gumasta_no'];
    gstNo = json['gst_no'];
    aadhar = json['aadhar'];
    pan = json['pan'];
    aadharCard = json['aadhar_card'];
    panCard = json['pan_card'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
    statement = json['statement'];
    officePhn = json['office_phn'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mandivyapari_id'] = this.mandivyapariId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['shop_name'] = this.shopName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['mandi_license'] = this.mandiLicense;
    data['gumasta'] = this.gumasta;
    data['gst_registration'] = this.gstRegistration;
    data['mandi_license_no'] = this.mandiLicenseNo;
    data['gumasta_no'] = this.gumastaNo;
    data['gst_no'] = this.gstNo;
    data['aadhar'] = this.aadhar;
    data['pan'] = this.pan;
    data['aadhar_card'] = this.aadharCard;
    data['pan_card'] = this.panCard;
    data['account_no'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    data['statement'] = this.statement;
    data['office_phn'] = this.officePhn;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
