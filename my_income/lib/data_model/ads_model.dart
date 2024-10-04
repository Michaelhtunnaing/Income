import 'dart:convert';

AdsModel adsModelFromJson(String str) => AdsModel.fromJson(json.decode(str));

String adsModelToJson(AdsModel data) => json.encode(data.toJson());

class AdsModel {
    final bool status;
    final String banner;
    final String interstrital;
    final String native;
    final String videoads;

    AdsModel({
        required this.status,
        required this.banner,
        required this.interstrital,
        required this.native,
        required this.videoads,
    });

    factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        status: json["status"],
        banner: json["banner"],
        interstrital: json["interstrital"],
        native: json["native"],
        videoads: json["videoads"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "banner": banner,
        "interstrital": interstrital,
        "native": native,
        "videoads": videoads,
    };
}
