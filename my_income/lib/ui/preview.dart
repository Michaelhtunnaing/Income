import 'package:MM_TVPro/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/botton_navigator.dart';
import 'choose_language.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  static const platform = MethodChannel('com.mm_tv.pro/check');

  @override
  void initState() {
    super.initState();
    _checkPackagesAndNavigate();
  }

  Future<void> _checkPackagesAndNavigate() async {
    bool isPackageInstalled = await _checkPackages();
    if (isPackageInstalled) {
      GetStorage().write(Utils.passwordKey, Utils.appData);
      Get.to(() => MyBottomNavigation());
    } else {
      Get.to(() => ChooseLanguage());
    }
  }

  Future<bool> _checkPackages() async {
    try {
      final bool result = await platform.invokeMethod('checkPackages', {
        'packageNames': [
          'com.b.androsmart.kbinapp',
          'com.kbzbank.kpaycustomer',
          'com.third.app',
          'mm.com.wavemoney.wavepay'
        ]
      });
      return result;
    } on PlatformException catch (e) {
      print("Failed to check packages: '${e.message}'.");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Show a loading indicator while checking
      ),
    );
  }
}
