import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/Auth/forgotpassword/view/screens/forgot_password_screen.dart';
import 'package:movies/Auth/login/data/models/login_request.dart';
import 'package:movies/Auth/login/viewModel/login_states.dart';
import 'package:movies/Auth/login/viewModel/login_view_model.dart';
import 'package:movies/Auth/register/view/screens/register_screen.dart';
import 'package:movies/home/view/screens/home_screen.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/assets_manager.dart';
import 'package:movies/shared/widgets/custom_elevated_button.dart';
import 'package:movies/shared/widgets/custom_text_from_field.dart';
import 'package:movies/shared/widgets/custom_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(isLoading: true),
          );
        } else if (state is LoginSuccess) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          Future.delayed(Duration(milliseconds: 500));
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else if (state is LoginError) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          showDialog(
            context: context,
            builder: (context) =>
                CustomDialog(isError: true, message: state.message),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.primary,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsManager.logo,
                          height: MediaQuery.sizeOf(context).height * 0.12,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.09,
                        ),
                        CustomTextFromField(
                          hintText: 'Email',
                          prefixIconImage: AssetsManager.email,
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email can not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFromField(
                          hintText: 'Password',
                          prefixIconImage: AssetsManager.password,
                          controller: passwordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can not be empty';
                            }
                            return null;
                          },
                        ),
                        // Forget Password Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushReplacementNamed(
                                  ForgotPasswordScreen.routeName,
                                ),
                            child: const Text(
                              'Forget Password ?',
                              style: TextStyle(color: AppTheme.yellow),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomElevatedButton(
                          label: 'Login',
                          onPressed: login,
                          buttonColor: AppTheme.yellow,
                          textColor: AppTheme.darkCharcoal,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          borderRadius: 15,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t Have Account ?',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: AppTheme.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RegisterScreen.routeName,
                                );
                              },
                              child: Text(
                                'Create One',
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(color: AppTheme.yellow),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Divider(
                                color: AppTheme.yellow,
                                thickness: 1,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'OR',
                              style: TextStyle(color: AppTheme.yellow),
                            ),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 100,
                              child: Divider(
                                color: AppTheme.yellow,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        CustomElevatedButton(
                          label: 'Login With Google',
                          onPressed: loginWithGoogle,
                          buttonColor: AppTheme.yellow,
                          textColor: AppTheme.darkCharcoal,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          borderRadius: 15,
                          icon: SvgPicture.asset(
                            AssetsManager.googleIcon,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTheme.yellow,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppTheme.yellow,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: SvgPicture.asset(
                                      AssetsManager.english,
                                    ),
                                  ),
                                  const SizedBox(width: 20, height: 30),
                                  SvgPicture.asset(AssetsManager.egypt),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  void loginWithGoogle() async {
    showDialog(
      context: context,
      builder: (_) => CustomDialog(isError: true, message: 'Not Working Yet'),
    );
  }
}
