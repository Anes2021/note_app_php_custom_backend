import 'package:flutter/material.dart';
import 'package:flutter_notes_app_with_php_custom_backend/helpers/app_colors.dart';
import 'package:flutter_notes_app_with_php_custom_backend/widgets/note_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150.h,
            backgroundColor: AppColors
                .backgroundColorOne, // Set custom background color here
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  Text(
                    "Note App",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 25,
                        ),
                  ),
                ],
              ),
              background: Container(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColorTwo,
                ),
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(67, 65, 71, 1.0)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.settings,
                    color: Colors.orange,
                    size: 30,
                  ),
                ),
              ),
              Gap(15.w),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.h),
                  child: const NoteCard(),
                );
              },
              childCount: 10, // Number of NoteCards
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define the action for adding a new note
        },
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
