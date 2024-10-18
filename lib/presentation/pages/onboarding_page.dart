import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:weather_app/presentation/pages/search_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  void _onPressed() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const SearchPage(
          isIntro: true,
        ),
      ),
    );
    context.read<OnboardingCubit>().saveOnboardingStatus(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.cloud_sun_rain_fill,
              color: Colors.lightBlue,
              size: 90,
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Discover the Weather in Your City",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Text(
                "Get to know your weather maps and radar precipitation forecast",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
            FilledButton(
              onPressed: _onPressed,
              child: const Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }
}
