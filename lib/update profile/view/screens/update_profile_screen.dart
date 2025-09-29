import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Auth/login/data/data_sources/local/login_shared_pref_data_source.dart';
import 'package:movies/shared/widgets/avatars_list.dart';
import 'package:movies/shared/widgets/custom_elevated_button.dart';
import 'package:movies/update%20profile/data/data_source/profile_api_data_source.dart';
import 'package:movies/update%20profile/data/repository/profile_repository.dart';
import 'package:movies/update%20profile/view%20model/profile_state.dart';
import 'package:movies/update%20profile/view%20model/profile_view_model.dart';
import 'package:movies/update%20profile/view/widgets/data_filler.dart';

import '../../../Auth/forgotpassword/view/screens/forgot_password_screen.dart';
import '../../../shared/constants/apptheme.dart';
import '../../view model/avatar_data.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/updateProfile';

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final List<String> avatars = AvatarData.avatarsList;
  int selectedIndex = 0;
  bool isinitalized = false;
  ProfileCubit? profileCubit;

  void initcubit() async {
    final token = await LoginSharedPrefDataSource().getToken();

    final dio = Dio();
    final dataSource = ProfileApiDataSource(dio);
    final repository = ProfileRepository(dataSource);

    final cubit = ProfileCubit(repository, token!);
    cubit.fetchProfile();
    setState(() {
      profileCubit = cubit;
    });
  }

  @override
  void initState() {
    initcubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return profileCubit == null
        ? Center(child: CircularProgressIndicator())
        : BlocProvider.value(
            value: profileCubit!,
            child: Scaffold(
              appBar: AppBar(title: Text('Pick Avatar')),
              body: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (_, state) {
                  if (state is ProfileLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProfileSuccess) {
                    if (!isinitalized) {
                      nameController.text = state.profile.name;
                      phoneController.text = state.profile.phone;
                      selectedIndex = state.profile.avaterId;
                      isinitalized = true;
                    }

                    return SafeArea(child: buildprofile());
                  } else if (state is ProfileError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: TextStyle(color: AppTheme.white),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),

              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Builder(
                      builder: (context) {
                        return CustomElevatedButton(
                          label: 'Delete Account',
                          onPressed: () {
                            context.read<ProfileCubit>().deleteProfile(context);
                          },
                          borderRadius: 15,
                          textColor: AppTheme.white,
                          buttonColor: AppTheme.red,
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    Builder(
                      builder: (context) => CustomElevatedButton(
                        label: 'Update Data',
                        onPressed: () {
                          context.read<ProfileCubit>().updateProfile(
                            nameController.text,
                            phoneController.text,
                            selectedIndex,
                          );
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                        borderRadius: 15,
                        textColor: AppTheme.black,
                        buttonColor: AppTheme.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildprofile() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickAvatar,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(avatars[selectedIndex]),
              ),
            ),
            SizedBox(height: 35),
            DataFiller(
              iconName: 'name',
              icon: Icons.person,

              controller: nameController,
            ),
            SizedBox(height: 19.28),
            DataFiller(
              iconName: 'phone',
              icon: Icons.phone_rounded,
              //  defaultText: userPhone,
              controller: phoneController,
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            // SizedBox(height: 265),
          ],
        ),
      ),
    );
  }

  void pickAvatar() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AvatarsList(
              avatars: avatars,
              selectedIndex: selectedIndex,
              onAvatarSelected: (index) {
                setModalState(() {
                  selectedIndex = index;
                });
                setState(() {
                  selectedIndex = index;
                  print("Selected avatar index: $selectedIndex");
                });

                // Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
