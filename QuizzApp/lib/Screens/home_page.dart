import 'package:flutter/material.dart';
import '../AppColors.dart';
import 'CreateQuizPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor, // Updated background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'QuickQuiz',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 40, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // Space between the title and image
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor, width: 2.0),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/homepage.png',
                    width: 250, // Adjust width
                    height: 250, // Adjust height
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateQuizPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Let's Start",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
