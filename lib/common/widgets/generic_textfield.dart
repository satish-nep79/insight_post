import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenericTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final String hint;
  final String? preIconPath;
  final String? suffixIconPath;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final Color? fillColor;
  final Color? hintColor;
  final bool? readOnly;
  final bool enableText;
  final bool? showError;
  final bool? autofocus;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final int? maxCharacters;
  final int? maxLines;
  final int? minLines;
  final double radius;
  final TextCapitalization textCapitalization;

  const GenericTextField({
    Key? key,
    this.fillColor,
    required this.hint,
    this.preIconPath,
    this.suffixIconPath,
    this.onValueChange,
    required this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border,
    this.readOnly = false,
    this.showError = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.maxCharacters,
    this.contentPadding,
    this.focusNode,
    this.enableText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.suffixIcon,
    this.prefixIcon,
    this.radius = 8,
    this.hintColor,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        minLines: minLines,
        focusNode: focusNode,
        maxLength: maxCharacters,
        autofocus: autofocus!,
        textCapitalization: textCapitalization,
        onFieldSubmitted: onSubmitted,
        onTap: (onTap != null) ? onTap! : null,
        readOnly: (readOnly == null) ? false : readOnly!,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLines: (maxLines! > minLines!) ? maxLines : minLines,
        validator: (validator != null) ? validator : null,
        controller: (controller != null) ? controller : null,
        onChanged: (text) {
          if (onValueChange != null) {
            onValueChange!(text);
          }
        },
        decoration: InputDecoration(
          suffixIconConstraints:
              BoxConstraints(maxHeight: 48.r, maxWidth: 48.r),
          fillColor: fillColor ?? theme.colorScheme.surface,
          filled: true,
          prefixIcon: (prefixIcon != null)
              ? prefixIcon
              : (preIconPath != null)
                  ? SvgPicture.asset(
                      preIconPath!,
                      fit: BoxFit.scaleDown,
                    )
                  : null,
          suffixIcon: (suffixIcon != null)
              ? suffixIcon
              : (suffixIconPath != null)
                  ? SizedBox(
                      child: SvgPicture.asset(
                        suffixIconPath!,
                        fit: BoxFit.scaleDown,
                        height: 16,
                        width: 16,
                      ),
                    )
                  : null,
          contentPadding: contentPadding ?? const EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide: BorderSide(
                width: 2,
                color: (border == null) ? theme.colorScheme.outline : border!),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: theme.colorScheme.error),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide:
                BorderSide(width: 1, color: border ?? theme.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide: BorderSide(width: 1, color: theme.colorScheme.error),
          ),
          errorStyle: (showError!)
              ? const TextStyle(fontSize: 12)
              : const TextStyle(fontSize: 0),
          hintText: hint,
          hintStyle: textTheme.bodyLarge!.copyWith(
            color: hintColor ?? theme.colorScheme.onSurface,
          ),
        ),
        style: textTheme.bodyLarge!.copyWith(
          color: enableText
              ? null
              : readOnly == true
                  ? theme.colorScheme.onSurface.withOpacity(0.5)
                  : null,
        ));
  }
}
