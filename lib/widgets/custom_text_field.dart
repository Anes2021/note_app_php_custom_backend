import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_php_custom_backend/helpers/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.enabled,
    required this.function,
    this.colors,
    this.textFieldHeight,
    this.maxLines,
    this.minLines,
  });
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final Function(String text) function;
  final bool? enabled;
  final int? textFieldHeight;
  final TextEditingController controller;
  final String hintText;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      onChanged: (
        String text,
      ) {
        function(
          text,
        );
      },
      keyboardType: keyboardType,
      enabled: enabled ?? true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.backgroundColorGrey01),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey01, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey01, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey02, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.backgroundColorGrey03,
        contentPadding: EdgeInsets.symmetric(
            vertical: (textFieldHeight ?? 15).toDouble(), horizontal: 10),
      ),
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: colors ?? AppColors.backgroundColorGrey02),
    );
  }
}
