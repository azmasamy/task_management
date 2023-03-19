import 'package:afs_task/core/style/style_constants/color_constants.dart';
import 'package:flutter/material.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: ColorConstants.kPrimaryColor,
    scaffoldBackgroundColor: ColorConstants.kSecondaryColorAccent,
    colorScheme: colorScheme,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
    highlightColor: ColorConstants.kSecondaryColor,
    splashColor: ColorConstants.kSecondaryColor,
    brightness: Brightness.light,
  );
}

final ColorScheme colorScheme = const ColorScheme.light().copyWith(
  primary: ColorConstants.kPrimaryColor,
  secondary: ColorConstants.kPrimaryAccentColor,
  error: ColorConstants.kErrorColor,
);
