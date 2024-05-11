import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/components/avatar/ns_avatar.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Avatar',
  type: NSAvatar,
)
Widget nsAvatar(BuildContext context) {
  return NSAvatar(imagePath: Assets.images.imgAvatar.path);
}
