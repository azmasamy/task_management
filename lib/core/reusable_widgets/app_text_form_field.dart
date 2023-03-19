import 'package:afs_task/core/style/style_constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
      this.onChange,
      required this.label,
      required this.textEditingController,
      this.autoFocus = false,
      this.isTextObsecured = false,
      this.suffixIcon,
      this.validator,
      this.minLines,
      this.maxLines,
      this.maxCharacters,
      this.hintText});

  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final String label;
  final TextEditingController textEditingController;
  final bool autoFocus;
  final bool isTextObsecured;
  final Widget? suffixIcon;
  final int? minLines;
  final int? maxLines;
  final int? maxCharacters;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, color: ColorConstants.kPrimaryAccentColor),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: validator,
          autofocus: autoFocus,
          minLines: minLines,
          maxLines: maxLines,
          controller: textEditingController,
          style: Theme.of(context).textTheme.bodyLarge,
          maxLength: maxCharacters,
          onChanged: onChange,
          obscureText: isTextObsecured,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            prefix: const SizedBox(width: 10),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: suffixIcon,
            ),
            suffixIconConstraints: suffixIcon != null
                ? const BoxConstraints(minHeight: 40, minWidth: 40)
                : const BoxConstraints(minWidth: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1.0, color: ColorConstants.kPrimaryAccentColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2.0, color: ColorConstants.kPrimaryColor),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1.0, color: ColorConstants.kPrimaryAccentColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}
