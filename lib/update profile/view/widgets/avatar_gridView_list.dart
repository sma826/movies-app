import 'package:flutter/material.dart';

import '../../../shared/constants/apptheme.dart';

class AvatarsList extends StatelessWidget {
  final List<String> avatars;
  final int selectedIndex;
  final Function(int) onAvatarSelected;

  const AvatarsList({
    super.key,
    required this.avatars,
    required this.selectedIndex,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: avatars.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 19,
          mainAxisSpacing: 19,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onAvatarSelected(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppTheme.transparentYellow.withValues(alpha:  0.5)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.transparentYellow.withValues(alpha:  0.5),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(avatars[index], fit: BoxFit.scaleDown),
              ),
            ),
          );
        },
      ),
    );
  }
}
