import 'package:flutter/material.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/assets_manager.dart';
import 'package:movies/shared/widgets/custom_elevated_button.dart';
import 'package:movies/shared/widgets/custom_text_from_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forget-password';
  final String from;

  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({super.key, required this.from});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        title: const Text('Forget Password'),
        centerTitle: true,
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.yellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (from == 'login') {
                Navigator.pushReplacementNamed(context, "/login");
              } else if (from == 'updateProfile') {
                Navigator.pushReplacementNamed(context, "/updateProfile");
              }
            }
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.forgotpassword,
                    height: MediaQuery.sizeOf(context).height * 0.50,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                  CustomTextFromField(
                    hintText: 'Email',
                    prefixIconImage: 'email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email can not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                  CustomElevatedButton(
                    label: 'Verify Email',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        verifyEmail();
                      }
                    },
                    buttonColor: AppTheme.yellow,
                    textColor: AppTheme.darkCharcoal,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    borderRadius: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void verifyEmail() {}
}
