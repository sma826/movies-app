import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarItem extends StatelessWidget {
  final String iconName;
  const BottomNavBarItem({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(iconName, width: 26);
  }
}
