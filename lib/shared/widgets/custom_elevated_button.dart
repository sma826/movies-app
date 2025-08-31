import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final Widget? icon;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
        fixedSize: Size(MediaQuery.sizeOf(context).width, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 8)],
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 18,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
