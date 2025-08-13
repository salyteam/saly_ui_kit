import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/buttons/button_type.dart';
import 'package:saly_ui_kit/src/utils/extenstion.dart';

class SalyIconButton extends StatelessWidget {
  const SalyIconButton.primary({
    required this.icon,
    this.onTap,
    this.size = 52,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    this.boxShadow,
    super.key,
  }) : _type = SalyButtonType.primary;

  const SalyIconButton.secondary({
    required this.icon,
    this.onTap,
    this.size = 52,
    this.boxShadow,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    super.key,
  }) : _type = SalyButtonType.secondary;

  const SalyIconButton.ghost({
    required this.icon,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    this.size = 52,
    this.boxShadow,
    super.key,
  }) : _type = SalyButtonType.ghost;

  final VoidCallback? onTap;
  final double size;
  final Widget icon;
  final EdgeInsets padding;
  final SalyButtonType _type;
  final List<BoxShadow>? boxShadow;

  bool get isDisabled => onTap == null;

  Color _backgroundColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => context.colors.statusAccentS1,
    SalyButtonType.secondary => context.colors.neutralSecondaryS2,
    SalyButtonType.ghost => context.colors.neutralPrimaryS2,
  };

  Color _backgroundDisabledColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => context.colors.statusAccentS1.withValues(alpha: 0.7),
    SalyButtonType.secondary => context.colors.neutralSecondaryS2.withValues(alpha: 0.7),
    SalyButtonType.ghost => context.colors.neutralPrimaryS1,
  };

  Color _splashColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => context.colors.statusAccentS2,
    _ => context.colors.neutralSecondaryS4,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(size * 2),
          splashColor: _splashColor(context),
          highlightColor: _splashColor(context),
          child: Ink(
            decoration: BoxDecoration(
              color: isDisabled ? _backgroundDisabledColor(context) : _backgroundColor(context),
              borderRadius: BorderRadius.circular(size * 2),
              border: _type == SalyButtonType.ghost
                  ? Border.all(color: context.colors.neutralSecondaryS3)
                  : null,
              boxShadow: boxShadow,
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
