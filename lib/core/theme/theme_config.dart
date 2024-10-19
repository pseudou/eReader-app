// lib/core/theme/theme_config.dart
import 'package:flutter/cupertino.dart';

class ThemeConfig {
  static CupertinoThemeData lightTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
  );

  static CupertinoThemeData darkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.black,
    primaryContrastingColor: CupertinoColors.inactiveGray,
    barBackgroundColor: CupertinoColors.quaternaryLabel,
    scaffoldBackgroundColor: CupertinoColors.black,

  );
}