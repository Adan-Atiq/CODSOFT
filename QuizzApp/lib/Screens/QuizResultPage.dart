import 'package:flutter/material.dart';
import '../AppColors.dart';

class QuizResultPage extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const QuizResultPage(
      {required this.totalQuestions, required this.correctAnswers, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scorePercentage = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: const Text("Quiz Result"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center( // Ensures that everything inside the body is centered
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image with border (round shape)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor, // Border color for the image
                    width: 4, // Border width
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/result.png',
                    width: 200,  // Increased size of the image
                    height: 200, // Increased size of the image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),  // Adjusted space

              // Card containing the result details with border and increased size
              Container(
                width: 350,  // Increased width of the card
                height: 350, // Increased height of the card
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: AppColors.primaryColor, width: 2), // Border for the card
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),  // Increased padding for card content
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quiz Completed!",
                          style: TextStyle(
                            fontSize: 28,  // Increased font size
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Total Questions: $totalQuestions",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Correct Answers: $correctAnswers",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Your Score: ${scorePercentage.toStringAsFixed(2)}%",
                          style: TextStyle(
                            fontSize: 24,  // Increased font size for score
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),  // Adjusted space

              // Button with secondary color for text and increased size
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),  // Increased padding
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back to Quiz List",
                  style: TextStyle(
                    fontSize: 20,  // Increased font size
                    color: AppColors.secondaryColor, // Changed text color to secondary
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
