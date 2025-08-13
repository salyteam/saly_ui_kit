import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:saly_ui_kit/src/utils/extenstion.dart';

class OtpField extends StatelessWidget {
  const OtpField({this.onChange, this.length = 4, this.hasError = false, super.key});

  final int length;
  final bool hasError;
  final void Function(String value)? onChange;

  @override
  Widget build(BuildContext context) => Pinput(
    length: length,
    onChanged: onChange,
    forceErrorState: hasError,
    errorPinTheme: PinTheme(
      height: MediaQuery.sizeOf(context).width * 0.13,
      width: MediaQuery.sizeOf(context).width * 0.1,
      textStyle: context.fonts.subtitle.copyWith(color: context.colors.statusErrorS1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.statusErrorS1),
        color: context.colors.statusErrorS3,
      ),
    ).copyDecorationWith(),
    defaultPinTheme: PinTheme(
      height: MediaQuery.sizeOf(context).width * 0.13,
      width: MediaQuery.sizeOf(context).width * 0.1,
      textStyle: context.fonts.subtitle,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.neutralSecondaryS3),
        color: context.colors.neutralPrimaryS1,
      ),
    ),
  );
}
