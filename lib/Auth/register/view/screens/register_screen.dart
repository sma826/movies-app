import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/Auth/login/view/screens/login_screen.dart';
import 'package:movies/Auth/register/view%20model/register_view_model.dart';
import 'package:movies/Auth/register/view/bloc/register_event.dart';
import 'package:movies/Auth/register/view/bloc/register_state.dart';
import 'package:movies/Auth/register/view/widgets/avatar_list.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/widgets/custom_elevated_button.dart';
import 'package:movies/shared/widgets/custom_text_from_field.dart';
import 'package:movies/shared/widgets/loading_indicator.dart';
import 'package:movies/update%20profile/view%20model/avatar_data.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int selectedAvatar = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.yellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          ),
        ),
      ),
      body: BlocConsumer<RegisterViewModel, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Registration Successful')));
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return LoadingIndicator();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarSelector(
                      avatars: AvatarData.avatarsList,
                      onSelected: (index) {
                        selectedAvatar = (index + 1);
                        log("Avatar selected: $index+1");
                      },
                    ),
                    SizedBox(height: 5),
                    const Text(
                      'Avatar',
                      style: TextStyle(color: AppTheme.white, fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    CustomTextFromField(
                      hintText: 'Name',
                      prefixIconImage: 'name',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFromField(
                      hintText: 'Email',
                      prefixIconImage: 'email',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email can't be empty";
                        } else if (value.length < 10 ||
                            !value.contains("@gmail.com")) {
                          return "email isn't correct";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFromField(
                      hintText: 'Password',
                      prefixIconImage: 'password',
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFromField(
                      hintText: 'Confirm Password',
                      prefixIconImage: 'password',
                      controller: confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm Password can't be empty";
                        } else if (value != passwordController.text) {
                          return "doesn't match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFromField(
                      hintText: 'Phone Number',
                      prefixIconImage: 'phone',
                      controller: phoneController,
                      isPassword: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone Number can't be empty";
                        } else if (value.length < 11) {
                          return "Phone Number isn't correct";
                        } else if (!value.startsWith('+2')) {
                          return "phone number must start with (+2)";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    CustomElevatedButton(
                      label: 'Create Account',
                      onPressed: () => validateAndRegister(),
                      buttonColor: AppTheme.yellow,
                      textColor: AppTheme.darkCharcoal,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      borderRadius: 15,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have Account ?',
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(color: AppTheme.white),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              ),
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: AppTheme.yellow),
                          ),
                        ),
                      ],
                    ),
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
                                child: SvgPicture.asset('assets/icons/LR.svg'),
                              ),
                              const SizedBox(width: 20, height: 30),
                              SvgPicture.asset('assets/icons/EG.svg'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void validateAndRegister() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || name.length < 3) {
      showError("Name must be at least 3 characters");
      return;
    }
    if (!email.contains("@") || !email.contains(".")) {
      showError("Enter a valid email address");
      return;
    }
    if (password.isEmpty || password.length < 8) {
      showError("Password must be at least 8 characters");
      return;
    }
    if (password != confirmPassword) {
      showError("Passwords do not match");
      return;
    }
    if (phone.isEmpty || phone.length < 11) {
      showError("Phone number must be at least 11 digits");
      return;
    }
    if (selectedAvatar == null) {
      showError("Please select an avatar");
      return;
    }

    context.read<RegisterViewModel>().add(
      RegisterEvent(
        name,
        email,
        password,
        confirmPassword,
        phone,
        selectedAvatar,
      ),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
