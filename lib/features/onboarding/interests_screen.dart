import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/rawData/interests.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your interests'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: Sizes.size24, right: Sizes.size24, bottom: Sizes.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v32,
              const Text(
                'Choose your interests',
                style: TextStyle(
                  fontSize: Sizes.size40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v20,
              const Text(
                'Get better video recommendations',
                style: TextStyle(
                  fontSize: Sizes.size20,
                ),
              ),
              Gaps.v40,
              // Grid 유사 위젯
              Wrap(
                spacing: Sizes.size15,
                runSpacing: Sizes.size15,
                children: [
                  for (var interest in interests)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size16,
                        horizontal: Sizes.size24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Sizes.size32),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.05)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5, // 둘레 번짐
                            spreadRadius: 5, // 둘레 퍼짐
                          )
                        ],
                      ),
                      child: Text(
                        interest,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size16,
            bottom: Sizes.size40,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: Sizes.size16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
