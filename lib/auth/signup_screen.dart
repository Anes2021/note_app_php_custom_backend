// ignore_for_file: await_only_futures

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_php_custom_backend/api/crud.dart';
import 'package:flutter_notes_app_with_php_custom_backend/auth/login_screen.dart';
import 'package:flutter_notes_app_with_php_custom_backend/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

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
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/myfirstphprestapi/auth/signup.php'),
        body: {
          "user_name": nameController.text,
          "user_email": emailController.text,
          "user_pass": passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          if (responseBody['status'] == "successful") {
            log("Sign-up completed successfully.");
            // Navigate to the next screen or show a success message
          } else {
            log("Sign-up failed: ${responseBody['message']}");
            // Show an error message to the user
          }
        } catch (e) {
          log("Error parsing response: $e");
          // Handle the error, for example by showing a generic error message
        }
      } else {
        log("Sign-up failed: Server error with status code: ${response.statusCode}");
      }
    } catch (e) {
      log("An error occurred: $e");
    }
  }
}
