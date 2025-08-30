import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';

class SalyTheme extends StatefulWidget {
  static SalyThemeState of(BuildContext context) {
    final result = context.findAncestorStateOfType<SalyThemeState>();
    assert(result != null);
    return result!;
  }

  const SalyTheme({required this.child, this.initBrightness = Brightness.light, this.onChangeTheme, super.key});

  final Widget child;
  final Brightness initBrightness;
  final void Function(Brightness currentValue)? onChangeTheme;

  @override
  State<SalyTheme> createState() => SalyThemeState();
}

class SalyThemeState extends State<SalyTheme> {
  late ColorThemeExtension _colors;
  late Brightness _brightness;
  late FontsExtension _fonts;

  bool get isLightTheme => _brightness == Brightness.light;
  bool get isDartTheme => _brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    _brightness = widget.initBrightness;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setDefaultTheme();
    _fonts = FontsExtension.base(color: _colors.neutralSecondaryS1);
  }

  void _setDefaultTheme() {
    if (_brightness == Brightness.light) {
      _colors = ColorThemeExtension.light();
    } else {
      _colors = ColorThemeExtension.dark();
    }
  }

  void changeTheme() {
    if (_brightness == Brightness.light) {
      _brightness = Brightness.dark;
      _colors = ColorThemeExtension.dark();
      _fonts = FontsExtension.base(color: _colors.neutralSecondaryS1);
    } else {
      _brightness = Brightness.light;
      _colors = ColorThemeExtension.light();
      _fonts = FontsExtension.base(color: _colors.neutralSecondaryS1);
    }
    widget.onChangeTheme?.call(_brightness);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: isDartTheme ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    child: Theme(
      data: ThemeData(
        scaffoldBackgroundColor: _colors.neutralPrimaryS2,
        appBarTheme: AppBarTheme(color: _colors.neutralPrimaryS2, surfaceTintColor: _colors.neutralPrimaryS2),
        extensions: [_colors, _fonts],
      ),
      child: widget.child,
    ),
  );
}
