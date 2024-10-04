import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../widgets/helper_widgets.dart';

Widget localBanner(String img, String url) {
  return InkWell(
    child: CachedNetworkImage(
      imageUrl: img,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.fill,
    ),
    onTap: () {
      if (url.isEmpty) {
        return;
      }
      MyWidget().gotoUrl(url);
    },
  );
}
