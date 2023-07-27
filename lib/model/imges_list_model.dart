// ignore_for_file: avoid_print

class ImageListModel {
  String? imgUrl;
  String? date;

  ImageListModel({
    this.imgUrl,
    this.date,
  });

  ImageListModel.fromJson(Map<String, dynamic> json) {
    try {
      imgUrl = json["img_url"];
    } catch (e) {
      print("Exception - ImagesModel.dart - ImagesModel.fromJson(): ${e.toString()}");
    }
  }

  Map<String, dynamic> toJson() => {
        "img_url": imgUrl,
      };
}
