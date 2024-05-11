import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/components/text_form_field/ns_text_form_field.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'TextField',
  type: NSTextFormField,
)
Widget nsTextFormField(BuildContext context) {
  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NSTextFormField.text(
            hintText: 'Email',
          ),
          const SizedBox(height: 20),
          NSTextFormField.password(
            hintText: 'Password',
          ),
        ],
      ),
    ),
  );
}
