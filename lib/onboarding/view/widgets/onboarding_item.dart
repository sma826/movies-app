import 'package:flutter/material.dart';
import 'package:movies/onboarding/data/data_source/local/onboarding_local_data_source.dart';
import 'package:movies/onboarding/data/data_source/local/onboarding_shared_pref_data_source.dart';
import 'package:movies/onboarding/data/models/onboarding_model.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/font_manager.dart';
import '../../../Auth/login/view/screens/login_screen.dart';

class OnboardingItem extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final VoidCallback ontap;
  final OnboardingModel data;
  final PageController controller;
  final OnBoardingLocalDataSource prefs = OnBoardingSharedPrefDataSource();

  OnboardingItem({
    super.key,
    required this.data,
    required this.ontap,
    required this.currentIndex,
    required this.totalPages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String buttonText = 'Explore Now';
    if (currentIndex > 0 && currentIndex < totalPages - 1) {
      buttonText = 'Next';
    } else if (currentIndex == totalPages - 1) {
      buttonText = 'Finish';
    }
    return Stack(
      children: [
        Image.asset(
          data.image,
          fit: BoxFit.cover,
          width: double.infinity,
          // height: double.infinity,
        ),
        Positioned(
          bottom: currentIndex != totalPages - 1 ? 0 : 20,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: currentIndex == 0 ? Colors.transparent : AppTheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(RadiusSizes.r40),
                topRight: Radius.circular(RadiusSizes.r40),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  data.title,
                  style: currentIndex == 0
                      ? textTheme.displaySmall
                      : textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                currentIndex != totalPages - 1
                    ? Text(
                        data.description,
                        style: currentIndex == 0
                            ? textTheme.titleLarge!.copyWith(
                                color: AppTheme.gray,
                              )
                            : textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      )
                    : SizedBox(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (currentIndex == totalPages - 1) {
                        await prefs.saveOnBoarding(true);
                        if (!context.mounted) return;
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(LoginScreen.routeName);
                      } else {
                        ontap();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.yellow,
                      foregroundColor: AppTheme.black,
                      fixedSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeightManager.fw600,
                        color: AppTheme.black,
                      ),
                    ),
                  ),
                ),
                if (currentIndex >= 2 && currentIndex <= totalPages - 1)
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.yellow),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: AppTheme.yellow,
                        fixedSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
