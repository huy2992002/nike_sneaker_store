import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/gen/fonts.gen.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NSStyle {
  static TextStyle primaryTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required String fontFamily,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  TextStyle h12Normal(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 12,
          tablet: 16,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w400,
      );

  TextStyle h12Medium(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 12,
          tablet: 16,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w500,
      );

  TextStyle h14Normal(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 14,
          tablet: 18,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w400,
      );

  TextStyle h14Medium(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 14,
          tablet: 18,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w500,
      );

  TextStyle h14SemiBold(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 14,
          tablet: 18,
        ),
        fontFamily: FontFamily.raleway,
        fontWeight: FontWeight.w600,
      );

  TextStyle h16ExtraLight(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 16,
          tablet: 20,
        ),
        fontFamily: FontFamily.raleway,
        fontWeight: FontWeight.w200,
      );

  TextStyle h16Normal(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 16,
          tablet: 20,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w400,
      );

  TextStyle h16Medium(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 16,
          tablet: 20,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w500,
      );

  TextStyle h16SemiBold(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 16,
          tablet: 20,
        ),
        fontFamily: FontFamily.raleway,
        fontWeight: FontWeight.w600,
      );

  TextStyle h16Bold(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 16,
          tablet: 20,
        ),
        fontFamily: FontFamily.raleway,
        fontWeight: FontWeight.w700,
      );

  TextStyle h18Semibold(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 18,
          tablet: 22,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w600,
      );

  TextStyle h20Medium(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 20,
          tablet: 24,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w500,
      );

  TextStyle h21SemiBold(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 21,
          tablet: 25,
        ),
        fontFamily: FontFamily.raleway,
        fontWeight: FontWeight.w600,
      );

  TextStyle h24Semibold(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 24,
          tablet: 28,
        ),
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w600,
      );

  TextStyle h26Bold(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 26,
          tablet: 30,
        ),
        fontFamily: FontFamily.ralewayBold,
        fontWeight: FontWeight.w700,
      );

  TextStyle h32Bold(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 32,
          tablet: 36,
        ),
        fontFamily: FontFamily.ralewayBold,
        fontWeight: FontWeight.w700,
      );

  TextStyle h32Black(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 32,
          tablet: 36,
        ),
        fontFamily: FontFamily.ralewayBlack,
        fontWeight: FontWeight.w900,
      );

  TextStyle h33Black(BuildContext context) => primaryTextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 33,
          tablet: 37,
        ),
        fontFamily: FontFamily.poppinsBold,
        fontWeight: FontWeight.w700,
      );
}
