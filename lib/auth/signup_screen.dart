// ignore_for_file: await_only_futures, use_build_context_synchronously

import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_php_custom_backend/api/api_links.dart';
import 'package:flutter_notes_app_with_php_custom_backend/api/crud.dart';
import 'package:flutter_notes_app_with_php_custom_backend/auth/login_screen.dart';
import 'package:flutter_notes_app_with_php_custom_backend/helpers/app_colors.dart';
import 'package:flutter_notes_app_with_php_custom_backend/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Crud _crud = Crud();

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
                "Create Account",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 35.sp,
                    ),
              ),
              Gap(50.h),
              CustomTextField(
                controller: nameController,
                hintText: 'Name',
                function: (String text) {},
              ),
              Gap(15.h),
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
                onTap: () {
                  signUp();
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
                        "Sign Up",
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Center(
                          child: Text(
                            "Go to Login",
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

  Future<void> signUp() async {
    //valoidationµ

    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      CherryToast.error(
        description: Text(
          "please fill all fields to complete signup operation",
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.backgroundColorGrey03),
        ),
      ).show(context);
    } else {
      try {
        var response = await _crud.postRequest(linkSignUp, {
          'user_name': nameController.text,
          'user_email': emailController.text,
          'user_pass': passwordController.text
        });
        if (response != null && response['status'] == 'successful') {
          CherryToast.success(
            description: Text(
              "You have successfully Sign-Up, Now login to confirm your informations.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.backgroundColorGrey03,
                  ),
            ),
          ).show(context);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
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
      } catch (e) {
        log("An error occurred: $e");
      }
    }
  }
}
