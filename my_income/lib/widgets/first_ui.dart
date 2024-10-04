import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:MM_TVPro/player/live_player.dart';
import '../ads_change/adschange.dart';
import '../controller/football_live_controller.dart';
import '../data_model/football_live_model.dart';
import 'helper_widgets.dart';

class FirstUi extends StatelessWidget {
  final DataModel model;
  final DataController controller;
  const FirstUi({super.key, required this.model, required this.controller});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    var width = MediaQuery.of(context).size;
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  expandedHeight: orientation == Orientation.portrait
                      ? width.height / 3.0
                      : width.height / 3,
                  flexibleSpace: FlexibleSpaceBar(
                    title: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: 'Match\n',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "\tof the day",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ]),
                    ),
                    titlePadding: const EdgeInsets.only(bottom: 190, left: 15),
                    background: Stack(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                        child: Center(
                          child: GestureDetector(
                            child: Image.asset('assets/images/R.jpg',
                                fit: BoxFit.fill,
                                width: orientation == Orientation.portrait
                                    ? width.width
                                    : width.width,
                                height: width.height),
                            onTap: () {
                              model.firstTeam.links.isEmpty
                                  ? MyWidget().showAboutDialog(context,
                                      'ယခု လက်ရှိ ပွဲချိန် မပြသသေးပါ ${model.firstTeam.time} မှ ဝင်ရောက်ကြည့်ရှု့ပေးပါ')
                                  : firstTeamWidget(
                                      context,
                                      orientation,
                                      model.firstTeam.hname,
                                      model.firstTeam.aname,
                                      textStyle);
                            },
                          ),
                        ),
                      ),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyWidget().cachedNetWorkImage(
                              model.firstTeam.hlogo, 75, 75),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 28),
                              RichText(
                                  text: const TextSpan(children: [
                                TextSpan(
                                    text: 'Premier\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                TextSpan(
                                    text: '\t\t\t\t\t\tLeague',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ])),
                              model.firstTeam.links.isEmpty
                                  ? Text(
                                      model.firstTeam.time,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )
                                  : Image.asset(
                                      'assets/images/live.png',
                                      height: 90,
                                      width: 90,
                                      fit: BoxFit.fill,
                                    ),
                            ],
                          ),
                          MyWidget()
                              .cachedNetWorkImage(model.firstTeam.alogo, 75, 75)
                        ],
                      ))
                    ]),
                  ),
                ),
              ];
            },
            body: RefreshIndicator(
              onRefresh: () async {
                controller.fetchdata();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: GestureDetector(
                        child: Card(
                          elevation: 20,
                          shadowColor: const Color.fromARGB(255, 123, 159, 189),
                          child: SizedBox(
                            height: orientation == Orientation.portrait
                                ? width.height / 8.4
                                : width.height / 4.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  height: 60,
                                  width: 60,
                                  child: FittedBox(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                            text: '\t\tMonth\n\n',
                                            style: TextStyle(
                                                color: Colors.yellow,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                "\t\t\t${model.secondTeam.month}\t\t",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                    ),
                                  ),
                                ),
                                Stack(children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(model.secondTeam.hname,
                                              style: textStyle),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Vs',
                                            style: textStyle,
                                          ),
                                          Text(
                                            model.secondTeam.aname,
                                            style: textStyle,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                  model.firstTeam.links.isEmpty
                                      ? Positioned(
                                          top: 50,
                                          left: 14,
                                          child: Text(
                                            model.firstTeam.time,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 99, 93, 93),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : Positioned(
                                          top: orientation ==
                                                  Orientation.portrait
                                              ? 40
                                              : 25,
                                          child: Image.asset(
                                            'assets/images/live.png',
                                            height: 70,
                                            width: 75,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                ])
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          model.secondTeam.links.isEmpty
                              ? MyWidget().showAboutDialog(context,
                                  "ယခု လက်ရှိ ပွဲချိန် မပြသသေးပါ ${model.secondTeam.time} မှ ဝင်ရောက်ကြည့်ရှု့ပေးပါ'")
                              : secondTeamWidget(
                                  context,
                                  orientation,
                                  model.secondTeam.hname,
                                  model.secondTeam.aname,
                                  textStyle);
                        },
                      ),
                    ),
                    AdsChange().showBanner(),
                    for (var league in model.leagues)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Row(
                              children: [
                                MyWidget().cachedNetWorkImage(
                                    league.leagueIcon, 35, 35),
                                SizedBox(width: 10),
                                Text(league.leagueName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: league.matches.length,
                            itemBuilder: (context, index) {
                              var matchTime = league.matches[index].time;
                              DateTime parsedTime =
                                  DateFormat('h:mm:ss a').parse(matchTime);
                              String formattedTime =
                                  DateFormat('h:mm a').format(parsedTime);
                              var match = league.matches[index];

                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: InkWell(
                                  child: Card(
                                    elevation: 30,
                                    shadowColor: const Color.fromARGB(
                                        255, 123, 159, 189),
                                    child: SizedBox(
                                      height:
                                          orientation == Orientation.portrait
                                              ? width.height / 10
                                              : width.height / 7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: 70,
                                            child: Text(
                                              match.homeTeam.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          MyWidget().cachedNetWorkImage(
                                              match.homeTeam.logo, 40, 40),
                                          Container(
                                            alignment: Alignment.center,
                                            //color: Colors.red,
                                            width: 80,
                                            child: match.links.isEmpty
                                                ? Text(
                                                    '[$formattedTime]',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 99, 93, 93),
                                                    ),
                                                  )
                                                : Image.asset(
                                                    'assets/images/live.png'),
                                          ),
                                          MyWidget().cachedNetWorkImage(
                                              match.awayTeam.logo, 40, 40),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 4),
                                            // color: Colors.red,
                                            alignment: Alignment.centerLeft,
                                            width: 70,
                                            child: Text(
                                              match.awayTeam.name,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    match.links.isEmpty
                                        ? MyWidget().showAboutDialog(context,
                                            'ယခု လက်ရှိ ပွဲချိန် မပြသသေးပါ ${match.time} မှ ဝင်ရောက်ကြည့်ရှု့ပေးပါ')
                                        : showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 300,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                            match.homeTeam.name,
                                                            style: textStyle),
                                                        Text("Vs"),
                                                        Text(
                                                            match.awayTeam.name,
                                                            style: textStyle),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: GridView.builder(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                            childAspectRatio:
                                                                orientation ==
                                                                        Orientation
                                                                            .portrait
                                                                    ? 2.5
                                                                    : 3.5,
                                                            crossAxisSpacing:
                                                                10,
                                                            crossAxisCount: 2),
                                                        itemCount:
                                                            match.links.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final url = match
                                                              .links[index].url;
                                                          final name = match
                                                              .links[index]
                                                              .name;
                                                          final links =
                                                              match.links;
                                                          return Card(
                                                            elevation: 5,
                                                            shadowColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    123,
                                                                    159,
                                                                    189),
                                                            child:
                                                                GestureDetector(
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    border: Border.all(
                                                                        width:
                                                                            2)),
                                                                child:
                                                                    Text(name),
                                                              ),
                                                              onTap: () {
                                                                Get.back();
                                                                AdsChange()
                                                                    .showInterstital();
                                                                Get.to(() => MyVlcPlayer(
                                                                    homeName: match
                                                                        .homeTeam
                                                                        .name,
                                                                    homeImg: match
                                                                        .homeTeam
                                                                        .logo,
                                                                    awayName: match
                                                                        .awayTeam
                                                                        .name,
                                                                    awayImg: match
                                                                        .awayTeam
                                                                        .logo,
                                                                    link: url,
                                                                    url: links,
                                                                    istrue:
                                                                        true,
                                                                    iswake:
                                                                        true));
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }); //op
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ));
      }),
    );
  }

  Future<dynamic> firstTeamWidget(BuildContext context, Orientation orientation,
      String hname, String aname, TextStyle textStyle) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(hname, style: textStyle),
                    Text("Vs"),
                    Text(aname, style: textStyle),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            orientation == Orientation.portrait ? 2.5 : 4.5,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2),
                    itemCount: model
                        .firstTeam.links.length, //model.firstTeam.links.length,
                    itemBuilder: (context, index) {
                      final url = model.firstTeam.links[index].url;
                      final name = model.firstTeam.links[index].name;
                      final links = model.firstTeam.links;
                      return Card(
                        elevation: 5,
                        shadowColor: const Color.fromARGB(255, 123, 159, 189),
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 2)),
                            child: Text(name),
                          ),
                          onTap: () {
                            Get.back();
                            AdsChange().showInterstital();
                            Get.to(() => MyVlcPlayer(
                                homeName: model.firstTeam.hname,
                                homeImg: model.firstTeam.hlogo,
                                awayName: model.secondTeam.aname,
                                awayImg: model.secondTeam.alogo,
                                link: url,
                                url: links,
                                istrue: true,
                                iswake: true));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> secondTeamWidget(
      BuildContext context,
      Orientation orientation,
      String hname,
      String aname,
      TextStyle textStyle) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(hname, style: textStyle),
                    Text("Vs"),
                    Text(aname, style: textStyle),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            orientation == Orientation.portrait ? 2.5 : 4.5,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2),
                    itemCount: model.secondTeam.links.length,
                    itemBuilder: (context, index) {
                      final url = model.secondTeam.links[index].url;
                      final name = model.secondTeam.links[index].name;
                      final links = model.secondTeam.links;
                      return Card(
                        elevation: 5,
                        shadowColor: const Color.fromARGB(255, 123, 159, 189),
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 2)),
                            child: Text(name),
                          ),
                          onTap: () {
                            Get.back();
                            AdsChange().showInterstital();
                            Get.to(() => MyVlcPlayer(
                                homeName: model.secondTeam.hname,
                                homeImg: model.secondTeam.hlogo,
                                awayName: model.secondTeam.aname,
                                awayImg: model.secondTeam.alogo,
                                link: url,
                                url: links,
                                istrue: true,
                                iswake: true));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
