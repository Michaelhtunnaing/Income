import 'dart:io';
import 'package:MM_TVPro/ui/preview.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:MM_TVPro/exception/handshake.dart';
import 'package:MM_TVPro/utils/constants.dart';
import 'ui/hightlight.dart';
import 'ui/choose_language.dart';
import 'utils/getinit.dart';
import 'utils/language_translations.dart';
import 'widgets/botton_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  FacebookAudienceNetwork.init(
      testingId: "bfbb19a0-3368-41ca-bfaa-2adb73399963");
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    GetInit().dependencies();
    return GetMaterialApp(
      translations: ChangeLanguage(),
      locale: Locale(ChangeLanguage.locale),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: GetStorage().read(Utils.passwordKey) == "၄၄၄၄၄"
          ? '/mybuttom'
          : '/preview',
      getPages: [
        GetPage(name: '/', page: () => ChooseLanguage()),
        GetPage(name: '/mybuttom', page: () => const MyBottomNavigation()),
        GetPage(name: '/myhightlight', page: () => const MyHighlight()),
        GetPage(name: '/preview', page: () => Preview()),
      ],
    );
  }
}
