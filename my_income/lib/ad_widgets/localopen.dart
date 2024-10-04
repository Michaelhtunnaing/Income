import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget localInterstitial(String img,BuildContext context) {
  var width = MediaQuery.of(context).size;
  return CachedNetworkImage(
    imageUrl: img,
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      child: CircularProgressIndicator(value: downloadProgress.progress),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    fit: BoxFit.fill,
    width: width.width,
    height: width.height,
  );
}
