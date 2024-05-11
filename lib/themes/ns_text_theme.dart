import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/resources/ns_style.dart';

class NSTextTheme {
  TextTheme textTheme(BuildContext context) {
    NSStyle nsStyle = NSStyle();
    return TextTheme(
      displayLarge: nsStyle.h33Black(context),
      displayMedium: nsStyle.h32Black(context),
      displaySmall: nsStyle.h32Bold(context),
      headlineLarge: nsStyle.h26Bold(context),
      headlineMedium: nsStyle.h24Semibold(context),
      headlineSmall: nsStyle.h21SemiBold(context),
      titleLarge: nsStyle.h20Medium(context),
      titleMedium: nsStyle.h18Semibold(context),
      titleSmall: nsStyle.h16Normal(context),
      bodyLarge: nsStyle.h16Bold(context),
      bodyMedium: nsStyle.h16Medium(context),
      bodySmall: nsStyle.h14Medium(context),
      labelLarge: nsStyle.h16SemiBold(context),
      labelMedium: nsStyle.h14SemiBold(context),
      labelSmall: nsStyle.h12Normal(context),
    );
  }
}
