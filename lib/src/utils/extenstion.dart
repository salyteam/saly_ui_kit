import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/theme/color_theme_extension.dart';
import 'package:saly_ui_kit/src/theme/font_extension.dart';

extension ThemeDataExt on BuildContext {
  ColorThemeExtension get colors {
    return Theme.of(this).extension<ColorThemeExtension>() ?? ColorThemeExtension.light();
  }

  FontsExtension get texts {
    return Theme.of(this).extension<FontsExtension>() ?? FontsExtension.fallback();
  }
}
