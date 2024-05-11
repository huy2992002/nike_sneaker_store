import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Button',
  type: NSElevatedButton,
)
Widget elevatedButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NSElevatedButton.text(
          onPressed: () {},
          text: context.knobs.string(
            label: 'Content NSElevatedButton.text',
            initialValue: 'Login',
          ),
        ),
        const SizedBox(height: 30),
        NSElevatedButton.icon(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.icons.icBag,
            height: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          text: context.knobs.string(
            label: 'Content NSElevatedButton.icon',
            initialValue: 'Add To Cart',
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Button',
  type: NsIconButton,
)
Widget iconButton(BuildContext context) {
  return NsIconButton(
    onPressed: () {},
    icon: SvgPicture.asset(
      Assets.icons.icArrow,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
    ),
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  );
}
