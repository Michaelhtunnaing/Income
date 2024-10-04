import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;
import 'package:MM_TVPro/player/live_player.dart';
import 'package:MM_TVPro/search/search.dart';
import 'package:MM_TVPro/widgets/helper_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../ads_change/adschange.dart';
import '../controller/movie_data_controller.dart';
import '../favourite_database.dart/database.dart';

class MyMovie extends GetView<MovieController> {
  MyMovie({super.key});
  final pageController = PageController();
  final Database _database = Get.put(Database());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return Obx(() {
            MovieState movieState = controller.moviestate.value;
            if (movieState is MovieLoading) {
              return Center(child: MyWidget().showLoadingAnimation());
            } else if (movieState is MovieSuccess) {
              final action = movieState.model.action;
              final horror = movieState.model.horror;
              final cartoon = movieState.model.cartoon;
              return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: const Text(
                          'MM_TV.PRO',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: const EdgeInsets.only(left: 290),
                          title: IconButton(
                              onPressed: () {
                                showSearch(
                                    context: context, delegate: Search());
                              },
                              icon: const Icon(Icons.search, size: 35)),
                        ),
                      )
                    ];
                  },
                  body: Column(
                    children: [
                      AdsChange().showBanner(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SmoothPageIndicator(
                            controller: pageController,
                            count: 3,
                            effect: const WormEffect(),
                            onDotClicked: (index) {}),
                      ),
                      Expanded(
                        child: PageView(
                          onPageChanged: (int id) {},
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            RefreshIndicator(
                              onRefresh: () async {
                                controller.fetchMovie();
                              },
                              child: GridView.builder(
                                itemCount: action.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                        crossAxisCount:
                                            orientation == Orientation.portrait
                                                ? 2
                                                : 4),
                                itemBuilder: (context, index) {
                                  return GridTile(
                                    footer: GridTileBar(
                                        title: Text(action[index].title),
                                        backgroundColor: const Color.fromARGB(
                                            255, 177, 151, 73),
                                        trailing: StreamBuilder(
                                          stream: _database.getFavourite(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final localData =
                                                  snapshot.data ?? [];
                                              final isfavourite = localData.any(
                                                  (value) =>
                                                      value.title ==
                                                      action[index].title);
                                              return IconButton(
                                                  onPressed: () {
                                                    if (isfavourite) {
                                                    } else {
                                                      _database.insertFavourite(
                                                          DatabaseTableCompanion(
                                                              title: drift.Value(
                                                                  action[index]
                                                                      .title),
                                                              img: drift.Value(
                                                                  action[index]
                                                                      .img),
                                                              link: drift.Value(
                                                                  action[index]
                                                                      .link)));
                                                    }
                                                  },
                                                  icon: isfavourite
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )
                                                      : const Icon(Icons
                                                          .favorite_border));
                                            }

                                            return const SizedBox();
                                          },
                                        )),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(80)),
                                      child: GestureDetector(
                                        child: MyWidget().cachedNetWorkImage(
                                            action[index].img, 0, 0),
                                        onTap: () {
                                          AdsChange().showInterstital();
                                          Get.to(() => MyVlcPlayer(
                                            homeImg: "",
                                            awayImg: "",
                                                homeName: "",
                                                awayName: "",
                                                url: const [],
                                                link: action[index].link,
                                                istrue: false,
                                                iswake: true,
                                              ));
                                        },

                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            GridView.builder(
                              itemCount: horror.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      crossAxisCount:
                                          orientation == Orientation.portrait
                                              ? 2
                                              : 4),
                              itemBuilder: (context, index) {
                                return GridTile(
                                  footer: GridTileBar(
                                      title: Text(horror[index].title),
                                      backgroundColor: const Color.fromARGB(
                                          255, 177, 151, 73),
                                      trailing: StreamBuilder(
                                        stream: _database.getFavourite(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final localData =
                                                snapshot.data ?? [];
                                            final isfavourite = localData.any(
                                                (value) =>
                                                    value.title ==
                                                    horror[index].title);
                                            return IconButton(
                                                onPressed: () {
                                                  if (isfavourite) {
                                                  } else {
                                                    _database.insertFavourite(
                                                        DatabaseTableCompanion(
                                                            title: drift.Value(
                                                                horror[index]
                                                                    .title),
                                                            img: drift.Value(
                                                                horror[index]
                                                                    .img),
                                                            link: drift.Value(
                                                                horror[index]
                                                                    .link)));
                                                  }
                                                },
                                                icon: isfavourite
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons.favorite_border));
                                          }

                                          return const SizedBox();
                                        },
                                      )),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(80)),
                                    child: GestureDetector(
                                      child: MyWidget().cachedNetWorkImage(
                                          horror[index].img, 0, 0),
                                      onTap: () {
                                        AdsChange().showInterstital();
                                        Get.to(MyVlcPlayer(
                                          homeImg: "",
                                          homeName: "",
                                          awayImg: "",
                                          awayName: "",
                                          url: const [],
                                          link: horror[index].link,
                                          istrue: false,
                                          iswake: true,
                                        ));
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            GridView.builder(
                              itemCount: cartoon.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      crossAxisCount:
                                          orientation == Orientation.portrait
                                              ? 2
                                              : 4),
                              itemBuilder: (context, index) {
                                return GridTile(
                                  footer: GridTileBar(
                                      title: Text(cartoon[index].title),
                                      backgroundColor: const Color.fromARGB(
                                          255, 177, 151, 73),
                                      trailing: StreamBuilder(
                                        stream: _database.getFavourite(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final localData =
                                                snapshot.data ?? [];
                                            final isfavourite = localData.any(
                                                (value) =>
                                                    value.title ==
                                                    cartoon[index].title);
                                            return IconButton(
                                                onPressed: () {
                                                  if (isfavourite) {
                                                  } else {
                                                    _database.insertFavourite(
                                                        DatabaseTableCompanion(
                                                            title: drift.Value(
                                                                cartoon[index]
                                                                    .title),
                                                            img: drift.Value(
                                                                cartoon[index]
                                                                    .img),
                                                            link: drift.Value(
                                                                cartoon[index]
                                                                    .link)));
                                                  }
                                                },
                                                icon: isfavourite
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons.favorite_border));
                                          }

                                          return const SizedBox();
                                        },
                                      )),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(80)),
                                    child: GestureDetector(
                                      child: MyWidget().cachedNetWorkImage(
                                          cartoon[index].img, 0, 0),
                                      onTap: () {
                                        AdsChange().showInterstital();
                                        Get.to(MyVlcPlayer(
                                          homeImg: "",
                                            homeName: "",
                                            awayImg: "",
                                            awayName: "",
                                            url: const [],
                                            link: cartoon[index].link,
                                            iswake: true,
                                            istrue: false));
                                      },
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ));
            } else if (movieState is MovieFailture) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/error.png", scale: 2),
                    const SizedBox(height: 20),
                    Text(
                      movieState.message,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.fetchMovie();
                        },
                        child: const Text('Please Retry'))
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          });
        }),
      ),
    );
  }
}
