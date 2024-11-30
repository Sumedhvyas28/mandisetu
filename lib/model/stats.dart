class Stats {
  String? commodity;
  List<Data>? data;

  Stats({this.commodity, this.data});

  Stats.fromJson(Map<String, dynamic> json) {
    commodity = json['commodity'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commodity'] = this.commodity;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  dynamic min;
  dynamic max;
  dynamic modal;

  Data({this.date, this.min, this.max, this.modal});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    min = json['min'];
    max = json['max'];
    modal = json['modal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['min'] = this.min;
    data['max'] = this.max;
    data['modal'] = this.modal;
    return data;
  }
}
