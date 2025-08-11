import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/buttons/buttons.dart';
import 'package:saly_ui_kit/src/gen/assets.gen.dart';
import 'package:saly_ui_kit/src/layout/layout.dart';
import 'package:saly_ui_kit/src/utils/extenstion.dart';

class DiscountCard extends StatelessWidget {
  static const Widget shimmer = Shimmer(height: 430);

  const DiscountCard({
    required this.description,
    required this.sale,
    required this.name,
    this.onFavoriteTap,
    this.category,
    this.imgBackground,
    this.companyImg,
    this.isLiked = false,
    super.key,
  });

  final String name;
  final String? category, description, imgBackground, companyImg;
  final int sale;
  final bool isLiked;
  final void Function(bool value)? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.colors.neutralPrimaryS1,
        boxShadow: [BoxShadow(blurRadius: 16, color: context.colors.shadowColor.withValues(alpha: 0.1))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: imgBackground ?? '',
                    height: 470,
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => SalyAssets.images.restourant.image(fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: _LogoBanner(
                    name: name,
                    imagePath: companyImg,
                    isLiked: isLiked,
                    onFavoriteTap: onFavoriteTap,
                  ),
                ),
                Positioned(top: 16, right: 16, child: _ShareButton(() {})),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Row(
                    spacing: 8,
                    children: [
                      if (category != null) _IndoChip(title: category!),
                      _IndoChip(title: '-$sale%'),
                    ],
                  ),
                ),
              ],
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Text(
                  description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.texts.body,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LogoBanner extends StatelessWidget {
  const _LogoBanner({required this.isLiked, required this.name, this.onFavoriteTap, this.imagePath});

  final String name;
  final String? imagePath;
  final bool isLiked;
  final void Function(bool value)? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.neutralPrimaryS1,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: imagePath ?? '',
                height: 59,
                width: 59,
                fit: BoxFit.cover,
                errorWidget: (context, _, __) => SalyAssets.images.restourant.image(fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (name.isNotEmpty)
                    Text(name, style: context.texts.h6, maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text(
                    'Health & Wellness',
                    style: context.texts.body.copyWith(color: context.colors.neutralSecondaryS5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (onFavoriteTap != null) SalyLikeButton(initValue: isLiked, onTap: onFavoriteTap!, size: 59),
          ],
        ),
      ),
    );
  }
}

class _IndoChip extends StatelessWidget {
  const _IndoChip({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: context.colors.statusAccentS2, borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(title, style: context.texts.subtitle.copyWith(color: context.colors.neutralPrimaryS1)),
    ),
  );
}

class _ShareButton extends StatelessWidget {
  const _ShareButton(this.onTap);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SalyAssets.icons.more.svg(
          colorFilter: ColorFilter.mode(context.colors.neutralPrimaryS1, BlendMode.srcIn),
        ),
      ),
    );
  }
}
