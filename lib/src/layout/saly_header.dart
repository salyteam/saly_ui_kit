import 'package:flutter/material.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';
import 'package:saly_ui_kit/src/utils/extenstion.dart';

const double _kToolBarHeight = 60;

abstract class SalyHeader extends StatelessWidget implements PreferredSizeWidget {
  const SalyHeader({
    this.title,
    this.titleWidget,
    this.trailing,
    this.leading,
    this.onTapBack,
    this.height = _kToolBarHeight,
    this.contentPadding,
    super.key,
  });

  const factory SalyHeader.preferred({
    VoidCallback? onTapBack,
    Widget? leading,
    String title,
    Widget? titleWidget,
    Widget? trailing,
    double height,
    EdgeInsets? contentPadding,
    Key? key,
  }) = _SalyHeaderPreferredImpl;

  const factory SalyHeader.sliver({
    VoidCallback? onTapBack,
    Widget? leading,
    String title,
    Widget? titleWidget,
    Widget? trailing,
    double height,
    bool pinned,
    bool floating,
    EdgeInsets? contentPadding,
    Key? key,
  }) = _SalyHeaderSliver;

  final Widget? leading, trailing, titleWidget;
  final String? title;
  final VoidCallback? onTapBack;
  final double height;
  final EdgeInsets? contentPadding;

  @override
  Size get preferredSize => Size(double.infinity, height);

  Widget buildHeader(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: context.colors.neutralPrimaryS2),
    child: Padding(
      padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.transparent,
            child:
                leading ??
                SalyButton.ghost(
                  radius: 52,
                  size: Size.square(52),
                  onTap: onTapBack ?? () => Navigator.pop(context),
                  child: SalyAssets.icons.arrowLeft.svg(),
                ),
          ),
          if (titleWidget != null) titleWidget! else if (title != null) Text(title!, style: context.fonts.h6),
          trailing ?? const SizedBox.square(dimension: 52),
        ],
      ),
    ),
  );
}

final class _SalyHeaderPreferredImpl extends SalyHeader {
  const _SalyHeaderPreferredImpl({
    super.onTapBack,
    super.leading,
    super.title,
    super.titleWidget,
    super.trailing,
    super.height,
    super.contentPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SafeArea(child: buildHeader(context));
}

final class _SalyHeaderSliver extends SalyHeader {
  const _SalyHeaderSliver({
    super.onTapBack,
    super.leading,
    super.title,
    super.titleWidget,
    super.trailing,
    super.height,
    super.contentPadding,
    this.pinned = false,
    this.floating = false,
    super.key,
  });

  final bool pinned, floating;

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
    pinned: pinned,
    floating: floating,
    delegate: _HeaderDelegate(builder: (context) => buildHeader(context), height: height),
  );
}

final class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  _HeaderDelegate({required this.builder, required this.height});

  final double height;
  final WidgetBuilder builder;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => builder(context);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
