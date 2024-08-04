import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;
  final double? width;
  final bool isDisabled;
  final Color? backGroundColor;
  final Color? textColor;
  const GenericButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.height = 50,
      this.isDisabled = false,
      this.backGroundColor,
      this.textColor,
      this.width});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backGroundColor ?? theme.colorScheme.secondary,
            minimumSize:
                width != null ? Size(width!, height) : Size.fromHeight(height),
            disabledBackgroundColor: theme.colorScheme.outline,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: isDisabled ? null : onTap,
        child: Text(
          title,
          style: textTheme.bodyLarge?.copyWith(
            color: isDisabled
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onSurface,
          ),
        ));
  }
}
