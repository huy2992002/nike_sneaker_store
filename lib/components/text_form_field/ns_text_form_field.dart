import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NSTextFormField extends StatefulWidget {
  /// Create an [TextFormField]
  ///
  /// The [hintText] arguments must not be null.
  /// The [isPassword] arguments value default is false
  const NSTextFormField.text({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textInputType,
    this.isPassword = false,
    this.readOnly = false,
    super.key,
  });

  /// Create [TextFormField] for password in app Nike Sneaker
  ///
  /// The [hintText] arguments must not be null.
  factory NSTextFormField.password({
    required String hintText,
    TextEditingController? controller,
    Function(String)? onChanged,
    FormFieldValidator<String>? validator,
    Function(String)? onFieldSubmitted,
    TextInputAction? textInputAction,
    bool readOnly = false,
  }) {
    return NSTextFormField.text(
      hintText: hintText,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      isPassword: true,
      readOnly: readOnly,
    );
  }

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController]
  final TextEditingController? controller;

  /// String hint text for [TextFormField]
  final String hintText;

  /// Action when changing keyboard values
  ///
  /// The [onChanged] arguments can null
  final Function(String)? onChanged;

  /// Form validator value of [TextFormField]
  ///
  /// The [validator] arguments can null
  final FormFieldValidator<String>? validator;

  /// Action when onTap [textInputAction]
  ///
  /// The [onFieldSubmitted] arguments can null
  final Function(String)? onFieldSubmitted;

  /// Value of [TextInputAction]
  ///
  /// The [textInputAction] arguments can null
  final TextInputAction? textInputAction;

  /// Type of Input [TextFormField]
  ///
  /// The [textInputType] arguments can null
  final TextInputType? textInputType;

  /// If [isPassword] arguments is true [TextFormField] is password
  final bool isPassword;

  /// If[readOnly] arguments is true [TextFormField] only read disable input
  final bool readOnly;

  @override
  State<NSTextFormField> createState() => _NSTextFormFieldState();
}

class _NSTextFormFieldState extends State<NSTextFormField> {
  bool _isShowPassword = false;
  @override
  void initState() {
    _isShowPassword = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondaryContainer,
        contentPadding: EdgeInsets.symmetric(
          horizontal:
              getValueForScreenType(context: context, mobile: 14, tablet: 18),
          vertical: getValueForScreenType(context: context, mobile: 16, tablet: 24),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: widget.hintText,
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () => setState(() => _isShowPassword = !_isShowPassword),
                child: SvgPicture.asset(
                  _isShowPassword
                      ? Assets.icons.icEyeHidden
                      : Assets.icons.icEye,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 24,
          maxWidth: 48,
          minHeight: 24,
          minWidth: 48,
        ),
      ),
      obscureText: _isShowPassword,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      readOnly: widget.readOnly,
    );
  }
}
