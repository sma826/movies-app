import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/shared/constants/apptheme.dart';

class CustomTextFromField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? prefixIconImage;
  final Color? prefixIconColor;
  final void Function(String)? onChanged;
  final bool isPassword;
  final int? minLines;
  final int? maxLines;
  final String? Function(String?)? validator;

  const CustomTextFromField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.prefixIconImage,
    this.prefixIconColor,
    this.isPassword = false,
    this.minLines,
    this.maxLines,
    this.validator,
  });

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: AppTheme.white),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      minLines: widget.minLines,
      maxLines: widget.maxLines ?? 1,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppTheme.white),
        filled: true,
        fillColor: AppTheme.darkCharcoal,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        prefixIcon: widget.prefixIconImage != null
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/${widget.prefixIconImage}.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    widget.prefixIconColor ?? Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
