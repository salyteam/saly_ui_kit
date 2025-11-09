import 'package:flutter/material.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';

class SalyLikeButton extends StatefulWidget {
  const SalyLikeButton({this.onTap, this.onChange, this.initValue = false, this.size = 52, super.key});

  final bool initValue;
  final void Function(bool)? onChange;
  final VoidCallback? onTap;
  final double size;

  @override
  State<SalyLikeButton> createState() => _SalyLikeButtonState();
}

class _SalyLikeButtonState extends State<SalyLikeButton> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late bool _isSelect = widget.initValue;

  late Animation<double> _foregroundHeartSize;
  late Animation<double> _backgroundHeartSize;
  late Animation<double> _backgroundHeartColor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250), value: 1);

    _foregroundHeartSize = Tween<double>(
      begin: 1.2,
      end: 1,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));

    _backgroundHeartSize = Tween<double>(
      begin: 0.8,
      end: 1.6,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _backgroundHeartColor = Tween<double>(
      begin: 1,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  void _onTap() {
    if (widget.onChange != null) {
      setState(() => _isSelect = !_isSelect);
      widget.onChange?.call(_isSelect);
      _animationController.forward(from: 0.0);
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isSelect) ...[
              if (_animationController.status != AnimationStatus.completed)
                FadeTransition(
                  opacity: _backgroundHeartColor,
                  child: ScaleTransition(
                    scale: _backgroundHeartSize,
                    child: SalyAssets.icons.heart.svg(
                      colorFilter: ColorFilter.mode(context.colors.statusErrorS1, BlendMode.srcIn),
                      height: widget.size / 2,
                      width: widget.size / 2,
                    ),
                  ),
                ),

              ScaleTransition(
                scale: _foregroundHeartSize,
                child: SalyAssets.icons.heart.svg(
                  colorFilter: ColorFilter.mode(context.colors.statusErrorS1, BlendMode.srcIn),
                  height: widget.size / 2,
                  width: widget.size / 2,
                ),
              ),
            ] else ...[
              SalyAssets.icons.heart.svg(
                colorFilter: ColorFilter.mode(context.colors.neutralSecondaryS3, BlendMode.srcIn),
                height: widget.size / 2,
                width: widget.size / 2,
              ),

              if (_animationController.status != AnimationStatus.completed)
                FadeTransition(
                  opacity: _backgroundHeartColor,
                  child: SalyAssets.icons.heart.svg(
                    colorFilter: ColorFilter.mode(context.colors.statusErrorS1, BlendMode.srcIn),
                    height: widget.size / 2,
                    width: widget.size / 2,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
