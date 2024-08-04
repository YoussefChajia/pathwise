import 'package:flutter/material.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class NewSubjectPage extends StatelessWidget {
  NewSubjectPage({super.key});

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
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "What do you want to learn?",
                      style: AppTextStyles.header1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32.0),
                    Consumer<TextFieldProvider>(
                      builder: (context, provider, child) {
                        return TextFormField(
                          controller: TextEditingController(text: provider.text),
                          decoration: const InputDecoration(
                            hintText: 'Enter a subject...',
                            hintStyle: AppTextStyles.hint,
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.lightGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.light),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                            /// do something
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      children: _suggestions.map((suggestion) {
                        return GestureDetector(
                          onTap: () => Provider.of<TextFieldProvider>(context, listen: false).updateText(suggestion),
                          child: Chip(
                            label: Text(suggestion),
                            labelStyle: AppTextStyles.caption,
                            backgroundColor: AppColors.dark,
                            side: const BorderSide(color: AppColors.lightGrey),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
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
  String _text = '';

  String get text => _text;

  void updateText(String newText) {
    _text = newText;
    notifyListeners();
  }
}
