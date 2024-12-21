import 'package:flutter/material.dart';

import 'Login.dart';
import 'Register.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(), // Placeholder to push content to the bottom
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'images/start_image.png',
                    // Replace with your actual image path
                    width: 300, // Adjust the size of the image as needed
                    height: 400,
                  ),
                ),

                const SizedBox(height: 30), // Space between image and text

                const Text(
                  'Ухаалаг зарцуулж\nилүү хэмнэе',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF438883),
                    fontSize: 32, // Adjust text size
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 50), // Space between text and button

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    ); // Navigate to login
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(350, 60),
                    backgroundColor: Color(0xff3E7C78), // Button color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Эхлэх',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Хэрэглэгчийн эрх бий юу? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: const Text(
                      'Бүртгүүлэх',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff32819A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
