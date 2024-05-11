import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NSSearchBox extends StatelessWidget {
  /// Create an [TextFormField]
  const NSSearchBox({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.isCancel = false,
    this.onCancel,
  });

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController]
  final TextEditingController? controller;

  /// Action when changing keyboard values
  ///
  /// The [onChanged] arguments can null
  final Function(String)? onChanged;

  /// Action when onTap of [NSSearchBox]
  ///
  /// The [onTap] arguments can null
  final Function()? onTap;

  /// If [readOnly] arguments is true [TextFormField] is only read
  final bool readOnly;

  final bool isCancel;

  final Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        style: Theme.of(context).textTheme.labelMedium,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal:
                getValueForScreenType(context: context, mobile: 14, tablet: 18),
            vertical:
                getValueForScreenType(context: context, mobile: 16, tablet: 24),
          ),
          border: InputBorder.none,
          hintText: AppLocalizations.of(context).lookingForShoes,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 24, right: 12),
            child: SvgPicture.asset(
              Assets.icons.icSearch,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 24,
          ),
          suffixIcon: isCancel
              ? GestureDetector(
                  onTap: onCancel,
                  child: SvgPicture.asset(
                    Assets.icons.icCancel,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                )
              : null,
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 20, maxWidth: 48),
        ),
        readOnly: readOnly,
      ),
    );
  }
}
