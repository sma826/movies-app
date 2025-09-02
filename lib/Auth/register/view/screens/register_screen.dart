import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/home/view/screens/home_screen.dart';
import 'package:movies/Auth/login/view/screens/login_screen.dart';
import 'package:movies/Auth/register/view/widgets/avatar_list.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/assets_manager.dart';
import 'package:movies/shared/widgets/custom_elevated_button.dart';
import 'package:movies/shared/widgets/custom_text_from_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController RepasswordController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarSelector(
                  avatars: [
                    AssetsManager.avatar1,
                    AssetsManager.avatar8,
                    AssetsManager.avatar2,
                    AssetsManager.avatar4,
                    AssetsManager.avatar5,
                    AssetsManager.avatar6,
                    AssetsManager.avatar7,
                    AssetsManager.avatar3,
                    AssetsManager.avatar9,
                  ],
                  onSelected: (index) {
                    print("Avatar selected: $index");
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
                      return 'Name can not be empty';
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
                      return 'Email can not be empty';
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
                      return 'Password can not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFromField(
                  hintText: 'Confirm Password',
                  prefixIconImage: 'password',
                  controller: RepasswordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password can not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFromField(
                  hintText: 'Phone Number',
                  prefixIconImage: 'phone',
                  controller: PhoneController,
                  isPassword: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number can not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                CustomElevatedButton(
                  label: 'Create Account',
                  onPressed: createAccount,
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
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: AppTheme.white),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      ),
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppTheme.yellow,
                        ),
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
                        border: Border.all(color: AppTheme.yellow, width: 2),
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
      ),
    );
  }

  void createAccount() {
    if (formKey.currentState!.validate()) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
