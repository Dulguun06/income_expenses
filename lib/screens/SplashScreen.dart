import 'package:flutter/material.dart';
import 'package:income_expenses/screens/OnBoarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    callDelay(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF63B5AF), Color(0xFF438883)],
          ),
        ),
        child: Center(
          child: Text(
            'Сайн уу?',
            style: TextStyle(
                fontSize: 50,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Color(0xFFFEFEFE)),
          ),
        ),
      ),
    );
  }

  Future<void> callDelay(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoarding()),
      );
    });
  }
}
