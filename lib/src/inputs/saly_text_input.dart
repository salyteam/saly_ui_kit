import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';

class SalyTextInput<T> extends StatefulWidget {
  const SalyTextInput({
    this.suffixIconPath,
    this.minLines,
    this.maxLines,
    this.hintText,
    this.suffixIcon,
    this.contentPadding,
    this.validationMessages,
    this.control,
    this.editingController,
    this.onTapOutside,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.hasError = false,
    this.showErrors,
    this.onTap,
    this.style,
    this.isValid,
    super.key,
  });

  final int? maxLines, minLines;
  final String? hintText, suffixIconPath;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final FormControl<dynamic>? control;
  final TextInputType? keyboardType;
  final TextEditingController? editingController;
  final Map<String, String Function(Object)>? validationMessages;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool Function(FormControl<T>)? showErrors;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(FormControl<T>)? onTap;
  final FocusNode? focusNode;
  final TextStyle? style;
  final bool readOnly, autofocus, obscureText, hasError;
  final bool? isValid;

  @override
  State<SalyTextInput> createState() => _SalyTextInputState();
}

class _SalyTextInputState extends State<SalyTextInput> {
  late final FocusNode _focusNode;

  bool get _controlHasError => widget.control?.hasErrors == true && widget.control?.touched == true;

  bool get _hasFocus => _focusNode.hasFocus;

  Color get _borderColor {
    if (widget.readOnly) return context.colors.neutralSecondaryS3;
    if (_controlHasError) return context.colors.statusErrorS1;
    if (widget.isValid == true) return context.colors.statusOkS1;
    return context.colors.neutralSecondaryS3;
  }

  Color get _textColor {
    if (widget.readOnly) return context.colors.neutralSecondaryS6;
    if (_controlHasError) return context.colors.statusErrorS1;
    if (widget.isValid == true) return context.colors.statusOkS1;
    return context.colors.neutralSecondaryS1;
  }

  Color get _cursorColor {
    if (_controlHasError) return context.colors.statusErrorS1;
    return context.colors.neutralSecondaryS4;
  }

  Color get _hintTextColor {
    if (widget.readOnly) return context.colors.neutralSecondaryS4;
    if (_controlHasError) return context.colors.statusErrorS1;
    return context.colors.neutralSecondaryS4;
  }

  Color get _getPrimaryShadowColor {
    if (_hasFocus) return context.colors.statusInfoS1;
    return context.colors.shadowColor;
  }

  Color get _suffixIconColor {
    if (widget.readOnly) return context.colors.neutralSecondaryS4;
    if (_controlHasError) return context.colors.statusErrorS1;
    if (widget.isValid == true) return context.colors.statusOkS1;
    return context.colors.neutralSecondaryS2;
  }

  Color get _backgroundColor {
    if (widget.readOnly) return context.colors.neutralPrimaryS1;
    if (_controlHasError) return context.colors.statusErrorS2;
    if (widget.isValid == true) return context.colors.statusOkS2;
    if (_hasFocus) return context.colors.statusInfoS2;
    return context.colors.neutralPrimaryS1;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            if (!widget.readOnly) BoxShadow(blurRadius: 16, color: _getPrimaryShadowColor.withValues(alpha: 0.1)),
          ],
        ),
        child: ReactiveTextField(
          onTap: (details) {
            widget.onTap?.call(details);
            setState(() {});
          },
          focusNode: _focusNode,
          showErrors: widget.showErrors ?? (_) => false,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onTapOutside: widget.onTapOutside,
          formControl: widget.control ?? FormControl(),
          controller: widget.editingController,
          validationMessages: widget.validationMessages,
          style: widget.style ?? context.fonts.body.copyWith(color: _textColor),
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          cursorColor: _cursorColor,
          cursorErrorColor: context.colors.statusErrorS1,
          cursorHeight: 16,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: context.fonts.body.copyWith(color: _hintTextColor),
            filled: true,
            fillColor: _backgroundColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16)
              ..copyWith(
                top: widget.contentPadding?.top,
                bottom: widget.contentPadding?.bottom,
                left: widget.contentPadding?.left,
                right: widget.contentPadding?.right,
              ),
            suffixIcon:
                widget.suffixIcon ??
                (widget.suffixIconPath != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(
                          widget.suffixIconPath!,
                          colorFilter: ColorFilter.mode(_suffixIconColor, BlendMode.srcIn),
                        ),
                      )
                    : null),
            suffixIconColor: _suffixIconColor,
            suffixIconConstraints: const BoxConstraints(maxHeight: 24, maxWidth: 40),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _borderColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _borderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _borderColor),
            ),
          ),
        ),
      ),
    );
  }
}
