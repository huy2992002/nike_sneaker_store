import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/resources/ns_color.dart';

class NSSnackBar {
  /// Create [SnackBar] display notification
  ///
  /// The [title] arguments is display title of [SnackBar].
  ///
  /// The [color] arguments is display color of [SnackBar]
  /// If [color] is null, default value is [NSColor.darkPrimaryContainer]
  ///
  /// The [iconPath] arguments is display color of [SnackBar].
  /// If [iconPath] is null, default value is [Assets.icons.icTick]
  static void snackbarDefault(
    BuildContext context, {
    required String title,
    Color? color,
    String? iconPath,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 500),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: color ?? NSColor.darkPrimaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath ?? Assets.icons.icTick,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: NSColor.darkOnPrimaryContainer,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Create [SnackBar] display notification success with color green [NSColor.success]
  ///
  /// The [title] arguments is display title of [SnackBar].
  static void snackbarSuccess(
    BuildContext context, {
    required String title,
  }) {
    snackbarDefault(
      context,
      title: title,
      color: NSColor.success,
    );
  }

  /// Create [SnackBar] display notification error with color red [NSColor.error]
  ///
  /// The [title] arguments is display title of [SnackBar].
  static void snackbarError(
    BuildContext context, {
    required String title,
  }) {
    snackbarDefault(
      context,
      title: title,
      color: NSColor.error,
      iconPath: Assets.icons.icError,
    );
  }

  /// Create [SnackBar] display notification warning with color yellow [NSColor.warning]
  ///
  /// The [title] arguments is display title of [SnackBar].
  static void snackbarWarning(
    BuildContext context, {
    required String title,
  }) {
    snackbarDefault(
      context,
      title: title,
      color: NSColor.warning,
      iconPath: Assets.icons.icWarning,
    );
  }
}
