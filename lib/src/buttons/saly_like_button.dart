import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/gen/assets.gen.dart';
import 'package:saly_ui_kit/src/utils/extenstion.dart';

class SalyLikeButton extends StatefulWidget {
  const SalyLikeButton({required this.onTap, this.initValue = false, this.size = 52, super.key});

  final bool initValue;
  final void Function(bool) onTap;
  final double size;

  @override
  State<SalyLikeButton> createState() => _SalyLikeButtonState();
}

class _SalyLikeButtonState extends State<SalyLikeButton> {
  late bool _isSelect = widget.initValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() => _isSelect = !_isSelect);
          widget.onTap(_isSelect);
        },
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
            child: _isSelect
                ? SalyAssets.icons.heart.svg(
                    key: const ValueKey(1),
                    colorFilter: ColorFilter.mode(context.colors.statusErrorS1, BlendMode.srcIn),
                    height: 26,
                    width: 26,
                  )
                : SalyAssets.icons.heart.svg(
                    key: const ValueKey(2),
                    colorFilter: ColorFilter.mode(context.colors.neutralSecondaryS3, BlendMode.srcIn),
                    height: 26,
                    width: 26,
                  ),
          ),
        ),
      ),
    );
  }
}
