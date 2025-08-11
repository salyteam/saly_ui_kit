import 'package:flutter/material.dart';

abstract class BottomScrollSpacing extends StatelessWidget {
  const BottomScrollSpacing._({super.key, this.spacing});

  const factory BottomScrollSpacing.preferred({Key? key, double? spacing}) = _DefaultSpacing;

  const factory BottomScrollSpacing.sliver({Key? key, double? spacing}) = _SliverSpacing;

  final double? spacing;
}

final class _SliverSpacing extends BottomScrollSpacing {
  const _SliverSpacing({super.key, super.spacing}) : super._();

  @override
  Widget build(BuildContext context) =>
      SliverPadding(padding: EdgeInsets.only(top: spacing ?? MediaQuery.sizeOf(context).height * 0.14));
}

final class _DefaultSpacing extends BottomScrollSpacing {
  const _DefaultSpacing({super.key, super.spacing}) : super._();

  @override
  Widget build(BuildContext context) => SizedBox(height: spacing ?? MediaQuery.sizeOf(context).height * 0.14);
}
