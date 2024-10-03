// ignore_for_file: use_build_context_synchronously

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_php_custom_backend/api/api_links.dart';
import 'package:flutter_notes_app_with_php_custom_backend/api/crud.dart';
import 'package:flutter_notes_app_with_php_custom_backend/helpers/app_colors.dart';
import 'package:flutter_notes_app_with_php_custom_backend/screens/home_screen.dart';
import 'package:flutter_notes_app_with_php_custom_backend/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Crud crud = Crud();

  login() async {
    // Validation
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      CherryToast.error(
        description: Text(
          "Please fill in all fields to complete the registration process.",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.backgroundColorGrey03,
              ),
        ),
      ).show(context);
    } else {
      var response = await crud.postRequestAndCreateToken(linkLogin, {
        "user_pass": passwordController.text.trim(),
        "user_email": emailController.text.trim(),
      });

      if (response != null && response['status'] == 'successful') {
        CherryToast.success(
          description: Text(
            "You have successfully logged in.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.backgroundColorGrey03,
                ),
          ),
        ).show(context);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        CherryToast.error(
          description: Text(
            "Incorrect email or password, Please try again.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.backgroundColorGrey03,
                ),
          ),
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(150.h),
              Text(
                "Login",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 35.sp,
                    ),
              ),
              Gap(50.h),
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                function: (String text) {},
              ),
              Gap(15.h),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                function: (String text) {},
              ),
              Gap(20.h),
              GestureDetector(
                onTap: () async {
                  await login();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.5.h),
                    child: Center(
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 23.sp,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Colors.orange,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
