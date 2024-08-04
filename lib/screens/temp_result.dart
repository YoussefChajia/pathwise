import 'package:flutter/material.dart';
import 'package:pathwise/components/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:pathwise/providers/api_data.dart';

class TempResultPage extends StatelessWidget {
  final String argument;

  const TempResultPage({super.key, required this.argument});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'API Results', hasActionButton: false, leadingIcon: Icons.arrow_back),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* Container(
                alignment: Alignment.center,
                child: Text('API result for argument: $argument', style: AppTextStyles.header3),
              ), */
              Container(
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: Provider.of<ApiDataProvider>(context, listen: false).fetchData(argument),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Consumer<ApiDataProvider>(
                        builder: (context, apiDataProvider, child) {
                          return Center(child: Text(apiDataProvider.data ?? 'No data'));
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
