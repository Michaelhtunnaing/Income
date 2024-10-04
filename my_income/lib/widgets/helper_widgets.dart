import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MyWidget {
  Future<void> gotoUrl(String updateurl) async {
    final Uri url = Uri.parse(updateurl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget cachedNetWorkImage(String url,double width,double height) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fadeInCurve: Curves.fastOutSlowIn,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: LoadingAnimationWidget.discreteCircle(
        color:Color.fromARGB(255, 128, 6, 228),
        size: 50,
      )),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
   void showAboutDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

 Widget showLoadingAnimation(){
return LoadingAnimationWidget.discreteCircle(
        color:Color.fromARGB(255, 128, 6, 228),
        size: 45,
      );
  }

}
