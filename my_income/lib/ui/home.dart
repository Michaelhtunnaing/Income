import 'package:MM_TVPro/widgets/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/football_live_controller.dart';
import '../widgets/first_ui.dart';

class MyHome extends GetView {
  MyHome({super.key});

  final DataController _datacontroller = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      DataState state = _datacontroller.dataState.value;
      if (state is DataLoading) {
        return Center(child: MyWidget().showLoadingAnimation());
      }
      if (state is DataSuccess) {
        var model = state.model;
        return FirstUi(
          model: model,
          controller: _datacontroller,
        );
      }
      if (state is DataFailture) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/error.png", scale: 2),
              const SizedBox(height: 20),
              Text(
                state.message,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _datacontroller.fetchdata();
                  },
                  child: const Text('Please Retry'))
            ],
          ),
        );
      }
      return const SizedBox();
    }));
  }
}
