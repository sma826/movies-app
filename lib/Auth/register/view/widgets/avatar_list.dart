import 'package:flutter/material.dart';
import 'package:movies/shared/constants/apptheme.dart';

class AvatarSelector extends StatefulWidget {
  final List<String> avatars;
  final ValueChanged<int> onSelected;

  const AvatarSelector({
    required this.avatars,
    required this.onSelected,
    super.key,
  });

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  late PageController _pageController;
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.33,
      initialPage: selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.avatars.length,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onSelected(index);
        },
        itemBuilder: (context, index) {
          double radius = (index == selectedIndex) ? 80 : 47;
          return Center(
            child: CircleAvatar(
              radius: radius,
              backgroundColor: AppTheme.darkCharcoal,
              backgroundImage: AssetImage(widget.avatars[index]),
            ),
          );
        },
      ),
    );
  }
}
