// ignore_for_file: avoid_print

class ImagesModel {
  String? name;
  String? confidence;
  String? imgUrl;
  List<String>? additionalList;

  ImagesModel({
    this.name,
    this.imgUrl,
    this.additionalList,
    this.confidence,
  });

  ImagesModel.fromJson(Map<String, dynamic> json) {
    try {
      name = json["name"];
      confidence = json["confidence"];
      imgUrl = json["img_url"];
      additionalList = (json['additional'] != null && json['additional'].isNotEmpty) ? List<String>.from(json['additional'].map((e) => e)) : [];
    } catch (e) {
      print("Exception - ImagesModel.dart - ImagesModel.fromJson(): ${e.toString()}");
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "confidence": confidence,
        "img_url": imgUrl,
        "additional": additionalList,
      };
}
