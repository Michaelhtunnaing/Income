import 'dart:convert';

List<HighlightModel> highlightModelFromJson(String str) =>
    List<HighlightModel>.from(jsonDecode(str)).toList();

String highlightModelToJson(List<HighlightModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HighlightModel {
  final String title;
  final String url;


  HighlightModel({
    required this.title,
    required this.url,
  
  });

  factory HighlightModel.fromJson(Map<String, dynamic> json) => HighlightModel(
        title: json["title"],
        url: json["url"],
        
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
      
      };
}
