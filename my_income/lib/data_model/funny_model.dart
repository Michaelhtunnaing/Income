import 'dart:convert';

List<FunnyDataModel> previewModelFromJson(String str) => List<FunnyDataModel>.from(json.decode(str).map((x) => FunnyDataModel.fromJson(x)));

String previewModelToJson(List<FunnyDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FunnyDataModel {
    final String title;
    final String img;
    final String link;

    FunnyDataModel({
        required this.title,
        required this.img,
        required this.link,
    });

    factory FunnyDataModel.fromJson(Map<String, dynamic> json) => FunnyDataModel(
        title: json["title"],
        img: json["img"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "img": img,
        "link": link,
    };
}
