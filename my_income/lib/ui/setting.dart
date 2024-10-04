import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:MM_TVPro/ui/favourite.dart';
import 'package:MM_TVPro/utils/language_translations.dart';

import '../controller/theme_controller.dart';
import '../widgets/helper_widgets.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final List locale = [
    {"language": "English", "locale": "en_US"},
    {"language": "Chinese", "locale": "cn_CN"},
    {"language": "Myanmar", "locale": "my_MM"},
    {"language": "Thiland", "locale": "tt_TT"}
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
                            Navigator.pop(context);
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
      body: SingleChildScrollView(
              child: Stack(
      children: [
        Container(
            alignment: Alignment.topLeft,
            height: 200,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.asset(
                  'assets/images/R.jpg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                ))),
        Padding(
          padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white54),
            // height: 470,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Setting',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 4,
              ),
              Card(
                elevation: 15,
                shadowColor: Colors.black,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'language'.tr,
                          style: const TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              buildDialog(context);
                            },
                            icon: const Icon(
                              Icons.translate,
                              color: Colors.red,
                              size: 30,
                            ))
                      ],
                    )),
              ),
              Card(
                elevation: 15,
                shadowColor: Colors.black,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'like'.tr,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowFavourite()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.red,
                              size: 30,
                            )),
                      ],
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                elevation: 15,
                shadowColor: const Color.fromARGB(255, 128, 140, 150),
                child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'dark'.tr,
                          style: const TextStyle(fontSize: 20),
                        ),
                        GetX<ThemeController>(
                          builder: (controller) {
                            return Switch(
                                value: controller.isDarkMode.value,
                                onChanged: (value) {
                                  controller.changeTheme();
                                });
                          },
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Social",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 5,
              ),
              Card(
                elevation: 15,
                shadowColor: const Color.fromARGB(255, 128, 140, 150),
                child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Facebook",
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              MyWidget().gotoUrl(
                                  'https://www.facebook.com/profile.php?id=61553630237433&mibextid=eHce3h');
                            },
                            icon: const Icon(Icons.facebook, size: 30))
                      ],
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                elevation: 15,
                shadowColor: const Color.fromARGB(255, 128, 140, 150),
                child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Telegram",
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              MyWidget()
                                  .gotoUrl("https://t.me/mmallkarkoekar");
                            },
                            icon: const Icon(Icons.telegram, size: 30))
                      ],
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                elevation: 15,
                shadowColor: const Color.fromARGB(255, 128, 140, 150),
                child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Contact",
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              const email = "kanthitlugyi@gmail.com";
                              final Uri emailUrl = Uri(
                                scheme: 'mailto',
                                path: email,
                              );
                              MyWidget().gotoUrl(emailUrl.toString());
                            },
                            icon: const Icon(Icons.email, size: 30))
                      ],
                    )),
              ),
            ]),
          ),
        ),
      ],
              ),
            ),
    );
  }
}
