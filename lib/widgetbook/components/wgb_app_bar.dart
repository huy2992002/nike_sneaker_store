import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike_sneaker_store/components/app_bar/action_icon_app_bar.dart';
import 'package:nike_sneaker_store/components/app_bar/app_bar_home.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'AppBar',
  type: AppBarHome,
)
Widget appBarHome(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: AppBarHome(
      isMarkerNotification: context.knobs.boolean(label: 'Marker'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'AppBar',
  type: NSAppBar,
)
Widget nsAppBar(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: NSAppBar(
      title: context.knobs.string(
        label: 'Title',
        initialValue: 'Title App Bar',
      ),
      leftIcon: NsIconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          Assets.icons.icArrow,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      rightIcon: ActionIconAppBar(
        isMarked: context.knobs.boolean(label: 'Marker'),
      ),
      colorAppBar: Theme.of(context).colorScheme.background,
    ),
  );
}
