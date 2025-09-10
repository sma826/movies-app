import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/assets_manager.dart';

class CustomDialog extends StatelessWidget {
  final bool isLoading;
  final bool isError;
  final String message;

  const CustomDialog({
    super.key,
    this.isLoading = false,
    this.isError = false,
    this.message = '',
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      backgroundColor: AppTheme.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: size.height * 0.1),
          if (isLoading)
            Center(
              child: const CircularProgressIndicator(color: AppTheme.darkCharcoal),
            )
          else if (isError)
            Center(
              child: Column(
                children: [
                  Lottie.asset(AssetsManager.failed),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: size.height * 0.1),
        ],
      ),
    );
  }
}
