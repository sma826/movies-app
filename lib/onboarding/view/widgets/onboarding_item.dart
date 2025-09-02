import 'package:flutter/material.dart';
import 'package:movies/onboarding/viewModel/onboariding_data.dart';
import '../../../Auth/login/view/screens/login_screen.dart';

class OnboardingItem extends StatelessWidget {
  final int currentIndex;
  final int totalPages;
  final VoidCallback ontap;
  final OnboaridingData data;
  final PageController controller;

  const OnboardingItem({
    required this.data,
    required this.ontap,
    required this.currentIndex,
    required this.totalPages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: currentIndex == 0 ? Colors.transparent : Color(0xff121312),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Text(
                  data.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
                Text(
                  data.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentIndex == totalPages - 1) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        ontap();
                      }
                    },
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF6BD00),
                      foregroundColor: Colors.black,
                      fixedSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                if (currentIndex >= 2 && currentIndex <= totalPages - 1)
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF6BD00)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Color(0xffF6BD00),
                        fixedSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
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
