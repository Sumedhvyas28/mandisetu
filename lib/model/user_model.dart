class UserModel {
  User? user;

  UserModel({this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? mandiLicense;
  dynamic gumasta;
  dynamic gstRegistration;
  dynamic mandiLicenseNo;
  dynamic gumastaNo;
  dynamic gstNo;
  String? aadhar;
  String? pan;
  String? aadharCard;
  String? panCard;
  String? accountNo;
  String? ifscCode;
  String? statement;
  String? businessName;
  String? officeAddress;
  String? officePhn;
  String? image;
  String? role;
  String? agreement;
  dynamic emailVerifiedAt;
  String? token;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
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
        this.businessName,
        this.officeAddress,
        this.officePhn,
        this.image,
        this.role,
        this.agreement,
        this.emailVerifiedAt,
        this.token,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
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
    businessName = json['business_name'];
    officeAddress = json['office_address'];
    officePhn = json['office_phn'];
    image = json['image'];
    role = json['role'];
    agreement = json['agreement'];
    emailVerifiedAt = json['email_verified_at'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
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
    data['business_name'] = this.businessName;
    data['office_address'] = this.officeAddress;
    data['office_phn'] = this.officePhn;
    data['image'] = this.image;
    data['role'] = this.role;
    data['agreement'] = this.agreement;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
