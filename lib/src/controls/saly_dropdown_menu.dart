import 'package:flutter/material.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';

///Model for configuration DropDownMenu
class SalyDropDownMenuItem<T> {
  SalyDropDownMenuItem({required this.value, this.id, this.title});

  final int? id;
  final String? title;
  final T value;
}

class SalyDropDownMenu<T> extends StatefulWidget {
  const SalyDropDownMenu({
    required this.items,
    required this.onChange,
    this.isDisable = false,
    this.initValue,
    super.key,
  });

  final T? initValue;
  final List<SalyDropDownMenuItem> items;
  final void Function(SalyDropDownMenuItem<T> value) onChange;
  final bool isDisable;

  @override
  State<SalyDropDownMenu> createState() => _SalyDropDownMenuState<T>();
}

class _SalyDropDownMenuState<T> extends State<SalyDropDownMenu<T>> {
  late final LayerLink _layerLink = LayerLink();
  OverlayEntry? _entry;

  bool get _isActive => _entry != null;

  void _show() {
    if (_isActive) return;

    setState(() {
      _entry = OverlayEntry(
        builder: (context) {
          return Positioned(
            left: 20,
            right: 20,
            child: CompositedTransformFollower(
              offset: const Offset(0, 4),
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.topCenter,
              link: _layerLink,
              child: _DropDownMenuContent<T>(
                initValue: widget.initValue as T,
                onTapOutside: () => _close(),
                items: widget.items,
                onSelect: (value) {
                  widget.onChange(value);
                  // _close();
                },
              ),
            ),
          );
        },
      );
    });

    Overlay.of(context).insert(_entry!);
  }

  void _close() {
    _entry?.remove();
    setState(() => _entry = null);
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
    link: _layerLink,
    child: GestureDetector(
      onTap: widget.isDisable ? null : _show,
      child: Opacity(
        opacity: widget.isDisable ? 0.4 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            border: Border.all(color: _isActive ? context.colors.statusInfoS1 : context.colors.neutralSecondaryS3),
            borderRadius: BorderRadius.circular(16),
            color: _isActive ? context.colors.statusInfoS2 : context.colors.neutralPrimaryS1,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
            child: Row(
              children: [
                if (widget.initValue != null) Text(widget.initValue.toString(), style: context.fonts.body),
                const Spacer(),
                SalyAssets.icons.sort.svg(
                  colorFilter: ColorFilter.mode(context.colors.neutralSecondaryS2, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _DropDownMenuContent<T> extends StatefulWidget {
  const _DropDownMenuContent({required this.initValue, required this.items, required this.onSelect, this.onTapOutside});

  final T initValue;
  final List<SalyDropDownMenuItem> items;
  final VoidCallback? onTapOutside;
  final void Function(SalyDropDownMenuItem<T> value) onSelect;

  @override
  State<_DropDownMenuContent> createState() => _DropDownMenuContentState<T>();
}

class _DropDownMenuContentState<T> extends State<_DropDownMenuContent<T>> {
  final _animationDuration = const Duration(milliseconds: 170);
  CrossFadeState _state = CrossFadeState.showSecond;

  late T _currentValue = widget.initValue;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      setState(() => _state = CrossFadeState.showFirst);
    });
  }

  Future<void> _onTapOutside(PointerDownEvent _) async {
    setState(() => _state = CrossFadeState.showSecond);
    await Future.delayed(_animationDuration);
    widget.onTapOutside?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      sizeCurve: Curves.easeInOut,
      duration: _animationDuration,
      crossFadeState: _state,
      secondChild: const SizedBox.shrink(),
      firstChild: TapRegion(
        onTapOutside: _onTapOutside,
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.statusInfoS1),
                borderRadius: BorderRadius.circular(16),
                color: context.colors.neutralPrimaryS1,
                boxShadow: [BoxShadow(color: const Color(0xFF7AA6D9).withValues(alpha: .1), blurRadius: 16)],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final (i, item) in widget.items.indexed) ...[
                      _DropDownMenuItemWidget(
                        value: item.value == _currentValue,
                        title: item.title?.toString() ?? item.value,
                        onChange: (_) async {
                          setState(() => _currentValue = item.value);
                          widget.onSelect.call(item as SalyDropDownMenuItem<T>);
                        },
                      ),
                      if (i != widget.items.indexed.length - 1)
                        Divider(color: context.colors.neutralSecondaryS3, height: 1),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropDownMenuItemWidget extends StatelessWidget {
  const _DropDownMenuItemWidget({required this.value, required this.title, this.onChange});

  final String title;
  final bool value;
  final void Function(bool value)? onChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChange?.call(!value),
        splashColor: context.colors.neutralSecondaryS3.withValues(alpha: .4),
        highlightColor: context.colors.neutralSecondaryS3.withValues(alpha: .4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: context.fonts.body, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 170),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: value
                    ? SalyAssets.icons.statusOk.svg(
                        key: const ValueKey(1),
                        colorFilter: ColorFilter.mode(context.colors.statusInfoS1, BlendMode.srcIn),
                        height: 26,
                        width: 26,
                      )
                    : SizedBox.square(
                        dimension: 26,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: context.colors.neutralSecondaryS3),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
