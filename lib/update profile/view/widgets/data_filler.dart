import 'package:flutter/material.dart';

import '../../../shared/constants/apptheme.dart';

class DataFiller extends StatefulWidget {
  final String defaultText;
  final String iconName;
  final IconData icon;

  const DataFiller({
    super.key,
    required this.iconName,
    required this.icon,
    required this.defaultText,
  });

  @override
  State<DataFiller> createState() => _DataFillerState();
}

class _DataFillerState extends State<DataFiller> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.defaultText);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppTheme.white,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: AppTheme.white,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: AppTheme.white, size: 30),
        // prefixIcon: SvgPicture.asset('assets/icons/${widget.iconName}.svg'),
        filled: true,
        fillColor: AppTheme.grey,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppTheme.grey),
        ),
      ),
    );
  }
}
