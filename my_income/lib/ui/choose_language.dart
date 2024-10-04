import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MM_TVPro/controller/funnyData_controller.dart';
import 'package:MM_TVPro/ui/funny_ui.dart';
import '../utils/language_translations.dart';

class ChooseLanguage extends StatelessWidget {
 ChooseLanguage({super.key});

 final List locale = [
    {"language": "English", "locale": "en_US"},
    {"language": "Chinese", "locale": "cn_CN"},
    {"language": "Myanmar", "locale": "my_MM"}
  ];

  buildDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Choose Your Language'),
            content: SizedBox(
                width: double.maxFinite,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: GestureDetector(
                          child: Text(
                            locale[index]['language'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            ChangeLanguage()
                                .changeLanguage(locale[index]['locale']);
                            Get.put(FunnyDataController());
                            Get.to(() => FunnyUi());
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.blue);
                    },
                    itemCount: locale.length)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/ic_launcher.png'),
          const SizedBox(height: 55),
          Text(
            'hello'.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                buildDialog(context);
              },
              child: const Text("Choose Your Language")),
          const SizedBox(
            height: 40,
          ),
        ]),
      )),
    );
  }
}
