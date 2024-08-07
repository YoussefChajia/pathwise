import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pathwise/models/quiz.dart';
import 'package:pathwise/providers/quiz_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _suggestions = [
    'Java',
    'Python',
    'Unit Testing',
    'Data Structures',
    'Advanced Algorithms',
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TextFieldProvider(),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Consumer<TextFieldProvider>(builder: (context, provider, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "What do you want to learn?",
                          style: AppTextStyles.header1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32.0),
                        TextFormField(
                          controller: provider.controller,
                          onChanged: (value) {
                            provider.updateText(value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter a subject...',
                            hintStyle: AppTextStyles.hint,
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.all(Radius.circular(AppConstants.borderRadius)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.light),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
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
                                'Start Learning',
                                style: AppTextStyles.buttonLight,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (kDebugMode) print('Subject : ${provider.text}');
                                Navigator.of(context).pushNamed('/pre-assessment', arguments: provider.text);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.0,
                          children: _suggestions.map(
                            (suggestion) {
                              return GestureDetector(
                                onTap: () => provider.updateText(suggestion),
                                child: Chip(
                                  label: Text(suggestion),
                                  labelStyle: AppTextStyles.caption,
                                  backgroundColor: AppColors.dark,
                                  side: const BorderSide(color: AppColors.lightGrey),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldProvider extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  String get text => controller.text;

  void updateText(String newText) {
    controller.text = newText;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
