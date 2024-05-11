import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/components/otp/ns_otp_code.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'OTP',
  type: NSOtpCode,
)
Widget nsOTPCode(BuildContext context) {
  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: Center(
      child: NSOtpCode(
        codeLength: context.knobs.int.slider(
          label: 'Length OTP',
          initialValue: 4,
          min: 1,
          max: 5,
        ),
      ),
    ),
  );
}
