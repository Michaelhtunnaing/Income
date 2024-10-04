import 'package:MM_TVPro/widgets/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ads_change/adschange.dart';
import '../controller/football_highlight.dart';
import '../data_model/football_highlight.dart';
import '../player/embedded_player.dart';

class MyHighlight extends GetView<HighlightController> {
  const MyHighlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Obx(
              () {
                final state = controller.highlightstate.value;
                if (state is HighlightLoading) {
                  return Center(child: MyWidget().showLoadingAnimation());
                } else if (state is HighlightFailture) {
                  return _buildFailureState(state.message);
                } else if (state is HighlighSuccess) {
                  //HighlightSuccess
                  return _buildSuccessState(
                      context, size, orientation, state.model);
                } else {
                  return const Center(
                    child: Text('Unknown error'),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFailureState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/error.png", scale: 2),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.highlightfetch,
            child: const Text('Please Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, Size size,
      Orientation orientation, List<HighlightModel> data) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            title: Text(
              'MM_TV.PRO',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            AdsChange().showBanner(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.highlightfetch();
                },
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.1,
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                  ),
                  itemBuilder: (context, index) {
                    return _buildHighlightCard(
                        context, size, orientation, data[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightCard(BuildContext context, Size size,
      Orientation orientation, HighlightModel highlight) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => MyEmbedded(link: highlight.url));
            AdsChange().showInterstital();
          },
          child: Stack(
            children: [
              Card(
                elevation: 15,
                shadowColor: const Color.fromARGB(255, 123, 159, 189),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(
                    'assets/images/hh.png',
                    fit: BoxFit.fill,
                    height: orientation == Orientation.portrait
                        ? size.height / 5.4
                        : size.height / 2.2,
                    width: size.width / 2.4,
                  ),
                ),
              ),
              Positioned(
                top: orientation == Orientation.portrait ? 100 : 118,
                left: orientation == Orientation.portrait ? 18 : 35,
                child: SizedBox(
                  width: size.width / 3.3,
                  child: Text(
                    highlight.title,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
