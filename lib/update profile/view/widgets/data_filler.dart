import 'package:flutter/material.dart';

import '../../../shared/constants/apptheme.dart';

class DataFiller extends StatefulWidget {
  //  final String defaultText;
  final String iconName;
  final IconData icon;
  final TextEditingController controller;
  const DataFiller({
    super.key,
    required this.iconName,
    required this.icon,
    // required this.defaultText,
    required this.controller,
  });

  @override
  State<DataFiller> createState() => _DataFillerState();
}

class _DataFillerState extends State<DataFiller> {
  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
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
