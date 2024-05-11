import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';

class NSImageNetwork extends StatelessWidget {
  const NSImageNetwork({
    required this.path,
    this.width = 120,
    this.height = 54,
    this.fit = BoxFit.contain,
    super.key,
  });

  final String? path;
  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: !(path ?? '').contains('http')
          ? Image.asset(Assets.images.imgLogoApp.path)
          : CachedNetworkImage(
              imageUrl: path!,
              width: width,
              height: height,
              fit: fit,
              placeholder: (context, url) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.error),
              ),
            ),
    );
  }
}
