import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/utils/extenstion.dart';

class SalyCategoryChip extends StatefulWidget {
  const SalyCategoryChip({
    required this.value,
    required this.text,
    required this.onChange,
    this.icon,
    super.key,
  });

  final bool value;
  final String text;
  final Widget? icon;
  final ValueChanged<bool> onChange;

  @override
  State<SalyCategoryChip> createState() => _SalyCategoryChipState();
}

class _SalyCategoryChipState extends State<SalyCategoryChip> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  Color get _backgroundColor => context.colors.neutralPrimaryS1;
  Color get _borderColor => _value ? context.colors.statusAccentS1 : _backgroundColor;
  Color get _shadowColor => _value
      ? context.colors.statusAccentS1.withValues(alpha: 0.1)
      : context.colors.shadowColor.withValues(alpha: 0.1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _value = !_value);
        widget.onChange.call(_value);
      },
      child: Material(
        type: MaterialType.transparency,
        child: AnimatedContainer(
          duration: Durations.medium2,
          curve: Curves.easeInOut,
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: _borderColor, strokeAlign: BorderSide.strokeAlignInside),
            color: _backgroundColor,
            boxShadow: [BoxShadow(blurRadius: 16, offset: Offset(0, 4), color: _shadowColor)],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (widget.icon != null) widget.icon!,
              Flexible(
                child: Text(
                  widget.text,
                  style: context.fonts.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
