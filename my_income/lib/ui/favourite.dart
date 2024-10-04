import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../favourite_database.dart/database.dart';
import '../player/live_player.dart';

class ShowFavourite extends StatelessWidget {
  ShowFavourite({super.key});
  final Database _database = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _database.getFavourite(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data ?? [];
            if (data.isEmpty) {
              return const Center(
                child: Text('There is no favourite'),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                          )),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: data[index].img,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Text(
                              data[index].title,
                              style: const TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            )),
                            IconButton(
                                onPressed: () {
                                  _database.deleteFavourite(data[index]);
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                        onTap: (){
                          Get.to(()=>MyVlcPlayer(
                            homeImg: "",
                            homeName: "",
                            awayImg: "",
                            awayName: "",
                            link: data[index].link, istrue: false, iswake: true,url: const [],));
                        },
                      )),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
