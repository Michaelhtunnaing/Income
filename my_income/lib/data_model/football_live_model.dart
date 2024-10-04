import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
    final FirstTeamClass firstTeam;
    final FirstTeamClass secondTeam;
    final List<League> leagues;

    DataModel({
        required this.firstTeam,
        required this.secondTeam,
        required this.leagues,
    });

    factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        firstTeam: FirstTeamClass.fromJson(json["firstTeam"]),
        secondTeam: FirstTeamClass.fromJson(json["secondTeam"]),
        leagues: List<League>.from(json["leagues"].map((x) => League.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "firstTeam": firstTeam.toJson(),
        "secondTeam": secondTeam.toJson(),
        "leagues": List<dynamic>.from(leagues.map((x) => x.toJson())),
    };
}

class FirstTeamClass {
    final String hname;
    final String hlogo;
    final String aname;
    final String alogo;
    final String time;
    final String month;
    final List<Link> links;

    FirstTeamClass({
        required this.hname,
        required this.hlogo,
        required this.aname,
        required this.alogo,
        required this.time,
        required this.month,
        required this.links,
    });

    factory FirstTeamClass.fromJson(Map<String, dynamic> json) => FirstTeamClass(
        hname: json["hname"],
        hlogo: json["hlogo"],
        aname: json["aname"],
        alogo: json["alogo"],
        time: json["time"],
        month: json["month"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "hname": hname,
        "hlogo": hlogo,
        "aname": aname,
        "alogo": alogo,
        "time": time,
        "month": month,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
    };
}

class Link {
    final  String name;
    final String url;

    Link({
        required this.name,
        required this.url,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        name: json['name'],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}





class League {
    final String leagueName;
    final String leagueIcon;
    final List<Match> matches;

    League({
        required this.leagueName,
        required this.leagueIcon,
        required this.matches,
    });

    factory League.fromJson(Map<String, dynamic> json) => League(
        leagueName: json["league_name"],
        leagueIcon: json["league_icon"],
        matches: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "league_name": leagueName,
        "league_icon":leagueIcon,
        "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
    };
}

class Match {
    final AwayTeamClass homeTeam;
    final AwayTeamClass awayTeam;
    final String month;
    final String time;
    final List<Link> links;

    Match({
        required this.homeTeam,
        required this.awayTeam,
        required this.month,
        required this.time,
        required this.links,
    });

    factory Match.fromJson(Map<String, dynamic> json) => Match(
        homeTeam: AwayTeamClass.fromJson(json["home_team"]),
        awayTeam: AwayTeamClass.fromJson(json["away_team"]),
        month: json['month'],
        time: json['time'],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "home_team": homeTeam.toJson(),
        "away_team": awayTeam.toJson(),
        "month": month,
        "time": time,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
    };
}

class AwayTeamClass {
    final String name;
    final String logo;

    AwayTeamClass({
        required this.name,
        required this.logo,
    });

    factory AwayTeamClass.fromJson(Map<String, dynamic> json) => AwayTeamClass(
        name: json["name"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
    };
}




