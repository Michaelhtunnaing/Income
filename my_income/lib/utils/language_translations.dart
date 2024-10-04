import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangeLanguage extends Translations {
  static const String storageKey = 'savelocale';
  static final locale = GetStorage().read(storageKey) ?? 'en_US';
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': "English",
          'hi': "HI",
          'dark': "Dark Mode",
          'like': "Favourite",
          'language': "Change Language",
          "main": "Thanks You",
          "vpn": "If you can't see it, please use a VPN",
           "key": "Search here ==>"
        },
        'my_MM': {
          'hello': "Myanmar",
          'hi': "bbbbb",
          'dark': "အလင်း_အမှောင်",
          'like': "ကြိုက်နှစ်သက်သော",
          'language': "ဘာသာစကားပြောင်းရန်",
          "main": "လေး ငါးလုံးထည့်ဝင်ပေးပါနော်",
          "vpn": "ကြည့်ရှု့လို့မရပါက VPN အသုံးပြုပေးပါနော်",
          "key": "မှန်ဘီလူးပုံကိုနှိပ်ပါ ==>"
        },
        'cn_CN': {
          'hello': "Chinese",
          'hi': "bbbbb",
          'dark': "深色模式",
          'like': "最喜歡的",
          'language': "改變語言",
          "main": "感謝您",
          "vpn": "如果看不到 請使用VPN",
          "key": "在這裡搜尋 ==>"
        },
        'tt_TT': {
          'hello':"Thiland",
          "key": "ค้นหาที่นี่ ==>",
          "dark": "กลางวันกลางคืน",
          'like':"ที่ชื่นชอบ",
          "value": "4",
          "language":"เปลี่ยนภาษา",
          "main": "ขอบคุณ",
          "vpn": "หากไม่สามารถมองเห็นได้กรุณาใช้ VPN"
        }
      };
  void changeLanguage(String newLocale) {
    GetStorage().write(storageKey, newLocale);
    Get.updateLocale(Locale(newLocale));
  }
}
