import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/assets_manager.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,

        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: AppTheme.white),
          fillColor: AppTheme.grey,
          prefixIcon: SvgPicture.asset(
            AssetsManager.searchIcon,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),

          suffixIcon: IconButton(
            icon: Icon(Icons.clear, color: AppTheme.white),
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          ),
        ),
        style: TextStyle(
          color: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
