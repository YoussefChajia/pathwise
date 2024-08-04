import 'package:flutter/material.dart';
import 'package:pathwise/components/app_bar.dart';
import 'package:pathwise/utils/colors.dart';

class TempResultPage extends StatelessWidget {
  const TempResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'API Results', hasActionButton: false, leadingIcon: Icons.arrow_back),
        body: Column(
          children: [
            Container(
              color: AppColors.orange,
              child: Text('Temp Result Page'),
            ),
          ],
        ),
      ),
    );
  }
}
