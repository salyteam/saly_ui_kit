import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/buttons/button_type.dart';
import 'package:saly_ui_kit/src/utils/extension.dart';

class SalyButton extends StatelessWidget {
  const SalyButton.primary({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.size,
    this.shadow,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    super.key,
  }) : _type = SalyButtonType.primary,
       assert(child != null || title != null);

  const SalyButton.secondary({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.size,
    this.shadow,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    super.key,
  }) : _type = SalyButtonType.secondary,
       assert(child != null || title != null);

  const SalyButton.ghost({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.size,
    this.shadow,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    super.key,
  }) : _type = SalyButtonType.ghost,
       assert(child != null || title != null);

  final VoidCallback? onTap;
  final double radius;
  final Widget? child;
  final String? title;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final SalyButtonType _type;
  final List<BoxShadow>? shadow;
  final Size? size;

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
    return SizedBox.fromSize(
      size: size,
      child: Material(
        clipBehavior: Clip.none,
        color: Colors.transparent,
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          splashColor: _splashColor(context),
          highlightColor: _splashColor(context),
          child: Ink(
            decoration: BoxDecoration(
              color: isDisabled ? _backgroundDisabledColor(context) : _backgroundColor(context),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: shadow ?? [BoxShadow(color: _backgroundColor(context).withValues(alpha: 0.1), blurRadius: 16)],
            ),
            child: Padding(
              padding: size != null ? const EdgeInsets.all(0) : padding,
              child: Center(
                child:
                    child ??
                    (title != null
                        ? Text(
                            title!,
                            style:
                                textStyle ??
                                context.fonts.subtitle.copyWith(
                                  color: _textColor(context),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                          )
                        : null),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
