import 'package:flutter/material.dart';
import '../AppColors.dart';
import 'QuizResultPage.dart';

class QuizPage extends StatefulWidget {
  final String quizName;
  final List<Map<String, dynamic>> questions;

  const QuizPage({required this.quizName, required this.questions, Key? key})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  String? selectedAnswer;
  String feedbackMessage = '';
  bool showCorrectAnswer = false;
  bool isSubmitted = false; // Track if the question is submitted

  void _submitAnswer() {
    setState(() {
      // Check if the selected answer is correct
      if (selectedAnswer == widget.questions[currentQuestionIndex]['answer']) {
        correctAnswers++;
        feedbackMessage = 'Nice! You selected the correct answer!';
      } else {
        feedbackMessage = 'Incorrect! The correct answer is: ${widget.questions[currentQuestionIndex]['answer']}';
        showCorrectAnswer = true; // Show the correct answer if wrong
      }
      isSubmitted = true; // Mark the question as submitted
    });
  }

  void _moveToNextQuestion() {
    setState(() {
      // Reset feedback and selected answer for the next question
      selectedAnswer = null;
      feedbackMessage = '';
      showCorrectAnswer = false;
      isSubmitted = false; // Reset submission status

      if (currentQuestionIndex + 1 < widget.questions.length) {
        currentQuestionIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResultPage(
              totalQuestions: widget.questions.length,
              correctAnswers: correctAnswers,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.quizName,
          style: TextStyle(color: AppColors.secondaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add the Image with Border
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/quizpage.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20), // Space between image and card

            // Question inside a Card with Border
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppColors.primaryColor, width: 2), // Border added
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q${currentQuestionIndex + 1}: ${currentQuestion['question']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor, // Set question color to primary
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Options inside Card and clickable
                    ...currentQuestion['options'].map<Widget>((option) {
                      return ListTile(
                        title: Text(option),
                        leading: Radio<String>(
                          value: option[0],
                          groupValue: selectedAnswer,
                          onChanged: (value) {
                            setState(() {
                              selectedAnswer = value;
                              showCorrectAnswer = false;  // Reset showing correct answer on selection change
                              feedbackMessage = ''; // Reset feedback message
                            });
                          },
                        ),
                      );
                    }).toList(),
                    // Feedback message
                    if (feedbackMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          feedbackMessage,
                          style: TextStyle(
                            color: showCorrectAnswer ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Spacer(), // Space between question and buttons

            // Buttons for Submit and Next
            Row(
              children: [
                // Submit Answer Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor, // Primary color for button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppColors.primaryColor, width: 2), // Border added
                      ),
                    ),
                    onPressed: isSubmitted ? null : _submitAnswer, // Disable Submit after it's clicked
                    child: Text(
                      "Submit Answer",
                      style: TextStyle(
                        color: AppColors.secondaryColor, // Text color when background is primary
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons

                // Next Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor, // Secondary color for button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppColors.primaryColor, width: 2), // Border added
                      ),
                    ),
                    onPressed: isSubmitted ? _moveToNextQuestion : null, // Only allow Next after Submit
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: AppColors.primaryColor, // Text color when background is secondary
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
