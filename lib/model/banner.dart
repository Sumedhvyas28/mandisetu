class Banner {
  List<String>? banner;
  List<int>? id;

  Banner({this.banner, this.id});

  Banner.fromJson(Map<String, dynamic> json) {
    banner = json['banner'].cast<String>();
    id = json['id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner'] = this.banner;
    data['id'] = this.id;
    return data;
  }
}
