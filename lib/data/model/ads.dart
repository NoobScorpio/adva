class Ads {
  int id;
  String type;
  String media;
  String createdAt;
  String updatedAt;

  Ads({this.id, this.type, this.media, this.createdAt, this.updatedAt});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    media = json['media'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['media'] = this.media;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class AdsResultModel {
  List<Ads> ads;

  AdsResultModel({this.ads});

  AdsResultModel.fromJson(List<dynamic> json) {
    if (json != null) {
      ads = List<Ads>();
      json.forEach((v) {
        ads.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ads != null) {
      data['ads'] = this.ads.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
