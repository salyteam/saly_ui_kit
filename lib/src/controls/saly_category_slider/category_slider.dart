import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/controls/saly_category_chip.dart';
import 'package:saly_ui_kit/src/controls/saly_category_slider/models.dart';

class SalyCategorySlider extends StatefulWidget {
  const SalyCategorySlider({required this.items, required this.onChange, this.controller, super.key});

  final List<CategorySliderItem> items;
  final ScrollController? controller;
  final ValueChanged<List<CategorySliderItem>> onChange;

  @override
  State<SalyCategorySlider> createState() => _SalyCategorySliderState();
}

class _SalyCategorySliderState extends State<SalyCategorySlider> {
  final _allItems = <CategorySliderItem>[];
  final _currentItems = <CategorySliderItem>[];

  @override
  void initState() {
    super.initState();
    _allItems.addAll(widget.items);
    _currentItems.addAll(_allItems.where((e) => e.value));
  }

  void _onChange(CategorySliderItem item, bool isRemoved) {
    if (isRemoved) {
      setState(() => _currentItems.add(item));
    } else {
      setState(() => _currentItems.remove(item));
    }
    widget.onChange(_currentItems);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 12,
        children: _allItems
            .map(
              (i) => SalyCategoryChip(
                key: i.key,
                value: i.value,
                text: i.text,
                onChange: (value) => _onChange(i, value),
              ),
            )
            .toList(),
      ),
    );
  }
}
