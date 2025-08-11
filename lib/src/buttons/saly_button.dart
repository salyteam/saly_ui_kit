import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/buttons/button_type.dart';
import 'package:saly_ui_kit/src/utils/extenstion.dart';

class SalyButton extends StatelessWidget {
  const SalyButton.primary({
    required this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    super.key,
  }) : _type = SalyButtonType.primary;

  const SalyButton.secondary({
    required this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    super.key,
  }) : _type = SalyButtonType.secondary;

  const SalyButton.ghost({
    required this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    super.key,
  }) : _type = SalyButtonType.ghost;

  final VoidCallback? onTap;
  final double radius;
  final Widget? child;
  final String title;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final SalyButtonType _type;

  bool get isDisabled => onTap == null;

  Color _backgroundColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => context.colors.statusAccentS1,
    SalyButtonType.secondary => context.colors.neutralSecondaryS2,
    SalyButtonType.ghost => context.colors.neutralPrimaryS1,
  };

  Color _backgroundDisabledColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => context.colors.statusAccentS1.withValues(alpha: 0.7),
    SalyButtonType.secondary => context.colors.neutralSecondaryS2.withValues(alpha: 0.7),
    SalyButtonType.ghost => context.colors.neutralPrimaryS1,
  };

  Color _textColor(BuildContext context) {
    if (_type == SalyButtonType.ghost && isDisabled) {
      return context.colors.neutralSecondaryS2.withValues(alpha: 0.7);
    }

    return switch (_type) {
      SalyButtonType.ghost => context.colors.neutralSecondaryS2,
      _ => context.colors.neutralPrimaryS1,
    };
  }

  Color _splashColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => context.colors.statusAccentS2,
    _ => context.colors.neutralSecondaryS4,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      splashColor: _splashColor(context),
      highlightColor: _splashColor(context),
      child: Ink(
        decoration: BoxDecoration(
          color: isDisabled ? _backgroundDisabledColor(context) : _backgroundColor(context),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [BoxShadow(color: _backgroundColor(context).withValues(alpha: 0.1), blurRadius: 16)],
        ),
        child: Padding(
          padding: padding,
          child: Center(
            child:
                child ??
                Text(
                  title,
                  style:
                      textStyle ??
                      context.texts.subtitle.copyWith(
                        color: _textColor(context),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                ),
          ),
        ),
      ),
    );
  }
}
