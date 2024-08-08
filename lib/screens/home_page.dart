import 'package:flutter/material.dart';
import 'package:pathwise/components/custom_app_bar.dart';
import 'package:pathwise/components/course_card.dart';
import 'package:pathwise/providers/course_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _fetchAllCourses() async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    await courseProvider.fetchAllCourses();
  }

  @override
  void initState() {
    _fetchAllCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Hello Francesca', hasLeadingButton: false),
        body: Column(
          children: [
            Expanded(
              child: Consumer<CourseProvider>(
                builder: (context, courseProvider, child) {
                  return RefreshIndicator(
                    onRefresh: () => courseProvider.fetchAllCourses(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: courseProvider.courses.length,
                      itemBuilder: (context, index) {
                        return CourseCard(course: courseProvider.courses[index]);
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: AppColors.dark,
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
                backgroundColor: AppColors.light,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'New Subject',
                  style: AppTextStyles.buttonLight,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/new-subject');
              },
            ),
          ),
        ),
      ),
    );
  }
}
