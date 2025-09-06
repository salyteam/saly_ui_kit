import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalyTheme extends StatefulWidget {
  static SalyThemeState of(BuildContext context) {
    final result = context.findAncestorStateOfType<SalyThemeState>();
    assert(result != null);
    return result!;
  }

  const SalyTheme({required this.child, this.initBrightness = Brightness.light, this.storage, super.key});

  final Widget child;
  final SharedPreferences? storage;
  final Brightness initBrightness;

  @override
  State<SalyTheme> createState() => SalyThemeState();
}

class SalyThemeState extends State<SalyTheme> {
  static const _colorThemeKey = "color_theme";

  late ColorThemeExtension _colors;
  late Brightness _brightness;
  late FontsExtension _fonts;

  bool get isLightTheme => _brightness == Brightness.light;
  bool get isDartTheme => _brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setDefaultTheme();
    _fonts = FontsExtension.base(color: _colors.neutralSecondaryS1);
  }

  void _setDefaultTheme() {
    final brightnessIndex = widget.storage?.getInt(_colorThemeKey);
    final saveBrightness = brightnessIndex != null ? Brightness.values[brightnessIndex] : null;
    _brightness = saveBrightness ?? widget.initBrightness;
    if (_brightness == Brightness.light) {
      _colors = ColorThemeExtension.light();
    } else {
      _colors = ColorThemeExtension.dark();
    }
  }

  void changeTheme() {
    setState(() {
      if (_brightness == Brightness.light) {
        _brightness = Brightness.dark;
        _colors = ColorThemeExtension.dark();
        _fonts = FontsExtension.base(color: _colors.neutralSecondaryS1);
        widget.storage?.setInt(_colorThemeKey, Brightness.dark.index);
      } else {
        _brightness = Brightness.light;
        _colors = ColorThemeExtension.light();
        _fonts = FontsExtension.base(color: _colors.neutralSecondaryS1);
        widget.storage?.setInt(_colorThemeKey, Brightness.light.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: isDartTheme ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    child: Theme(
      data: ThemeData(
        scaffoldBackgroundColor: _colors.neutralPrimaryS2,
        appBarTheme: AppBarTheme(
          color: _colors.neutralPrimaryS2,
          surfaceTintColor: _colors.neutralPrimaryS2,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.green),
        ),
        extensions: [_colors, _fonts],
      ),
      child: widget.child,
    ),
  );
}
