import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/constants/typography.dart';
import 'package:jibber/core/providers/user_provider.dart';
import 'package:jibber/core/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: heading),
        centerTitle: true,
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    30.verticalSpace,
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: user.imageUrl != null
                          ? NetworkImage(user.imageUrl!)
                          : null,
                      child: user.imageUrl == null
                          ? Text(
                              user.name?[0].toUpperCase() ?? '',
                              style: heading.copyWith(fontSize: 40.sp),
                            )
                          : null,
                    ),
                    20.verticalSpace,
                    Text(
                      user.name ?? 'No Name',
                      style: heading.copyWith(fontSize: 24.sp),
                    ),
                    10.verticalSpace,
                    Text(
                      'ID: ${user.uid ?? 'No ID'}',
                      style: body.copyWith(color: Colors.grey),
                    ),
                    30.verticalSpace,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Text("Logout", style: body),
                      onPressed: () {
                        userProvider.clearUser();
                        AuthService().logout();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
