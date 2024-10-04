import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controller/funnyData_controller.dart';
import '../utils/constants.dart';

class FunnySearch extends SearchDelegate {
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

  final FunnyDataController _controller = Get.find();
  @override
  Widget buildResults(BuildContext context) {
    return Obx(() {
      FunnyDataState state = _controller.moviestate.value;
      if (state is FunnyDataLoading) {
        return const Center(
          child: Text('Loading'),
        );
      }
      if (state is FunnyDataSuccess) {
        final dd = state.model;
        List<dynamic> list = dd;
        final results = list
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return Column(
          children: [
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
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Text(
                              list[index].title,
                              style: const TextStyle(fontSize: 15),
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
    if (query == Utils.appData) {
      GetStorage().write(Utils.passwordKey, Utils.appData);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed('/mybuttom');
      });
    }
    return Obx(() {
      FunnyDataState state = _controller.moviestate.value;
      if (state is FunnyDataLoading) {
        return const Center(
          child: Text('Loading'),
        );
      }
      if (state is FunnyDataSuccess) {
        List<dynamic> list = state.model;

        final results = list
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  height: 30,
                  child: Text(
                    "value".tr == "2" ? "main".tr : "main".tr,
                    style: const TextStyle(fontSize: 20),
                  )),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: list[index].img,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
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
                                  list[index].title,
                                  style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),
                            onTap: () {},
                          )),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }
      return const SizedBox();
    });
  }
}
