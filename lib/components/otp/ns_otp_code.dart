import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class NSOtpCode extends StatelessWidget {
  /// Create card otp verification 
  ///
  /// The [codeLength] arguments have default value is [4]
  const NSOtpCode({
    this.controller,
    this.codeLength = 4,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.focusNode,
    super.key,
  });

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController]
  final TextEditingController? controller;

  /// length of otp code
  final int codeLength;

  /// Action when changing keyboard values
  /// 
  /// The [onChanged] arguments can null
  final Function(String)? onChanged;

  /// Action when completed input value
  /// 
  /// The [onCompleted] arguments can null
  final Function(String)? onCompleted;

  /// Action when onTap action of keyboard
  /// 
  /// The [onSubmitted] arguments can null 
  final Function(String)? onSubmitted;

  /// Defines the keyboard focus for this To give the keyboard focus to this widget, 
  /// provide a [focusNode] and then use the current [FocusScope] to request the focus: Don't forget to dispose focusNode
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 76,
      height: 56,
      textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Pinput(
      controller: controller,
      length: codeLength,
      defaultPinTheme: defaultPinTheme,
      onChanged: onChanged,
      onCompleted: onCompleted,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
    );
  }
}
