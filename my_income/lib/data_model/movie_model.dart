import 'dart:convert';

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
    final bool con;
    final String msg;
    final List<Action> action;
    final List<Action> horror;
    final List<Action> cartoon;

    MovieModel({
        required this.con,
        required this.msg,
        required this.action,
        required this.horror,
        required this.cartoon,
    });

    factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        con: json["con"],
        msg: json["msg"],
        action: List<Action>.from(json["action"].map((x) => Action.fromJson(x))),
        horror: List<Action>.from(json["horror"].map((x) => Action.fromJson(x))),
        cartoon: List<Action>.from(json["cartoon"].map((x) => Action.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "con": con,
        "msg": msg,
        "action": List<dynamic>.from(action.map((x) => x.toJson())),
        "horror": List<dynamic>.from(horror.map((x) => x.toJson())),
        "cartoon": List<dynamic>.from(cartoon.map((x) => x.toJson())),
    };
}

class Action {
    final String title;
    final String img;
    final String link;

    Action({
        required this.title,
        required this.img,
        required this.link,
    });

    factory Action.fromJson(Map<String, dynamic> json) => Action(
        title: json["Title"],
        img: json["Img"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "Title": title,
        "Img": img,
        "link": link,
    };
}



/*import 'dart:convert';

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
    final bool con;
    final String msg;
    final List<Datum> data;

    MovieModel({
        required this.con,
        required this.msg,
        required this.data,
    });

    factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        con: json["con"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "con": con,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    final String title;
    final String img;
    final String link;

    Datum({
        required this.title,
        required this.img,
        required this.link,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["Title"],
        img: json["Img"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "Title": title,
        "Img": img,
        "link": link,
    };
}
*/