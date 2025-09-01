import 'package:flutter/material.dart';
import 'package:movies/shared/widgets/avatars_list.dart';
import 'package:movies/shared/widgets/custom_elevated_button.dart';
import 'package:movies/update%20profile/view/widgets/data_filler.dart';

import '../../../shared/constants/apptheme.dart';
import '../../view model/avatar_data.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/update_profile';

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String userName = 'John Safwat';
  String userPhone = '01200000000';
  final List<String> avatars = AvatarData.avatarsList;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: AppTheme.yellow, size: 30),
        title: Text('Pick Avatar'),
      ),
      body: Padding(
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
              defaultText: userName,
            ),
            SizedBox(height: 19.28),
            DataFiller(
              iconName: 'phone',
              icon: Icons.phone_rounded,
              defaultText: userPhone,
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(height: 265),
            CustomElevatedButton(
              label: 'Delete Account',
              onPressed: () {},
              borderRadius: 15,
              textColor: AppTheme.white,
              buttonColor: AppTheme.red,
            ),
            SizedBox(height: 15),
            CustomElevatedButton(
              label: 'Update Data',
              onPressed: () {},
              borderRadius: 15,
              textColor: AppTheme.black,
              buttonColor: AppTheme.yellow,
            ),
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
