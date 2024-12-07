import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w3schools_project/widgets/custom_model.dart';

import '../pages/pages.dart';

class CustomIntroduction extends StatelessWidget {
  final String initialUrl;
  final SharedPreferences pref;
  const CustomIntroduction(
      {super.key, required this.initialUrl, required this.pref});

  @override
  Widget build(BuildContext context) {
    bool showIntro = pref.getBool('intro') ?? true;

    if (showIntro) {
      return IntroductionScreen(
        globalBackgroundColor: Colors.green,
        pages: [
          customViewModel(
              context,
              'assets/library.jpeg',
              'Comprehensive Tutorials',
              'Extensive tutorials on a wide range of web technologies for learners at all levels'),
          customViewModel(
              context,
              'assets/try_it_yourself.jpeg',
              'Interactive Examples And Exercises',
              'Interactive examples and exercises that allow users to practice and apply their knowledge in real-time'),
          customViewModel(
              context,
              'assets/navigat.jpeg',
              'User Friendly Interface',
              'Clean, well organized, and easy-to-navigate, making it easy to find information quickly'),
          customViewModel(
              context,
              'assets/cert.jpeg',
              'Certification And Learning Path',
              'Offers certification programs and structured learning paths to formally recognize skills and knowledge')
        ],
        dotsDecorator: const DotsDecorator(
          color: Colors.white,
          activeColor: Colors.black,
        ),
        done: const Text(
          "Let's Go!",
          style: TextStyle(color: Colors.white),
        ),
        next: const Text(
          'Next',
          style: TextStyle(color: Colors.white),
        ),
        onDone: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(
                pref: pref,
                initialUrl: initialUrl,
              ),
            ),
          );
        },
      );
    }
    return HomePage(
      pref: pref,
      initialUrl: initialUrl,
    );
  }
}
