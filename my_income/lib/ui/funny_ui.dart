import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/funnyData_controller.dart';
import '../data_model/funny_model.dart';
import '../player/youtube_Player.dart';
import '../utils/language_translations.dart';
import '../search/funny_search.dart';

class FunnyUi extends StatelessWidget {
  FunnyUi({super.key});
  final List list = [
    {"language": "English", "locale": "en_US"},
    {"language": "Myanmar", "locale": "my_MM"},
    {"language": "Chinese", "locale": "cn_CN"},
    {"language": "Thiland", "locale": "tt_TT"}
  ];

  void changeLocale(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose Language'),
            content: SizedBox(
              width: double.maxFinite,
              height: 190,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Text(
                        list[index]['language'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onTap: () {
                        ChangeLanguage().changeLanguage(list[index]['locale']);
                        Get.back();
                      },
                    );
                  },
                  separatorBuilder: (context, int index) {
                    return const Divider();
                  },
                  itemCount: list.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    FunnyDataController dataController = Get.find();
    const TextStyle textStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Text(
            "key".tr,
            style: textStyle,
          ),
          backgroundColor: const Color.fromARGB(255, 201, 187, 187),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: FunnySearch());
                },
                icon: const CircleAvatar(child: Icon(Icons.search))),
            IconButton(
                onPressed: () {
                  changeLocale(context);
                },
                icon: const CircleAvatar(child: Icon(Icons.translate)))
          ],
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(() {
                FunnyDataState state = dataController.moviestate.value;
                if (state is FunnyDataLoading) {
                  return Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/vpn.png', scale: 1.5),
                        const SizedBox(height: 10),
                        Text(
                          "vpn".tr,
                          style: const TextStyle(fontSize: 17),
                        ),
                        const SizedBox(height: 80),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
                if (state is FunnyDataSuccess) {
                  List<FunnyDataModel> data = state.model;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 500,
                                    crossAxisSpacing: 7.0,
                                    mainAxisSpacing: 7.0,
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              final link = data[index].link;
                              final img = data[index].img;
                              return GestureDetector(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: img,
                                        fit: BoxFit.fill,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              backgroundColor: Colors.redAccent,
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      data[index].title,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Get.to(() => FirstPlayer(id: link));
                                },
                              );
                            }),
                      )
                    ],
                  );
                }
                if (state is FunnyDataFailture) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              })),
        ));
  }
}
