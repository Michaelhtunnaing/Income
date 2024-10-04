import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MM_TVPro/player/live_player.dart';

import '../controller/movie_data_controller.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.search)),
        
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  final MovieController _controller = Get.find();
  @override
  Widget buildResults(BuildContext context) {
    return Obx(() {
      MovieState state = _controller.moviestate.value;
      if (state is MovieLoading) {
        return const Center(
          child: Text('Loading'),
        );
      }
      if (state is MovieSuccess) {
    
        final action = state.model.action;
        final cartoon = state.model.cartoon;
        final horror = state.model.horror;
    List<dynamic> list = [...action,...cartoon,...horror];
        final results = list
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      return  Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 20),
            height: 50,
           
            child: Text('Search Results ${results.length}')),
          Expanded(
            child: ListView.builder(
                itemCount: results.length,
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
                        child: Row(
                          children: [
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: list[index].img,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                           const SizedBox(width: 20,),
                            Expanded(
                                child: Text(
                                  list[index].title,style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ))
                          ],
                        )),
                  );
                },
              ),
          ),
        ],
      );
      }
      return const SizedBox();
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Obx(() {
      MovieState state = _controller.moviestate.value;
      if (state is MovieLoading) {
        return const Center(
          child: Text('Loading'),
        );
      }
      if (state is MovieSuccess) {
          final action = state.model.action;
        final cartoon = state.model.cartoon;
        final horror = state.model.horror;
    List<dynamic> list = [...action,...cartoon,...horror];
     
        final results = list
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return Column(
          children: [
            Container(
               alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 20),
            height: 50,
              child: Text('Movies ${list.length}'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
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
                                  imageUrl: list[index].img,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                             const SizedBox(width: 20,),
                              Expanded(
                                  child: Text(
                                    list[index].title,style: const TextStyle(fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                  ))
                            ],
                          ),
                          onTap: (){
                            Get.to(MyVlcPlayer(
                              homeImg: "",
                              homeName: "",
                              awayImg: "",
                              awayName: "",
                              url: const[],
                              link: list[index].link, istrue: false, iswake: true));
                          },
                        )),
                  );
                },
              ),
            ),
          ],
        );
      }
      return const SizedBox();
    });
  }
}
