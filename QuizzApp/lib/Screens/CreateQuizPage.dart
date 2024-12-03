import 'package:flutter/material.dart';
import '../AppColors.dart';
import 'QuizPage.dart';
import 'dart:math';  // Import to use Random

class CreateQuizPage extends StatelessWidget {
  const CreateQuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Updated quizzes list with new quiz names
    final List<String> quizzes = [
      "General Knowledge Quiz",
      "Geography Quiz",
      "Science Quiz",
      "History Quiz",
      "Culture Quiz",
      "Sports Quiz",  // New Quiz 1
      "Technology Quiz",  // New Quiz 2
      "Literature Quiz",  // New Quiz 3
      "Art & Music Quiz",  // New Quiz 4
      "Movies & TV Quiz",  // New Quiz 5
    ];

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'QuickQuiz',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                            quizName: quizzes[index],
                            questions: _getSampleQuestions(index),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          quizzes[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
                  // Randomly select a quiz from the list
                  final randomIndex = Random().nextInt(quizzes.length);

                  // Navigate to the QuizPage with the randomly selected quiz
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(
                        quizName: quizzes[randomIndex],
                        questions: _getSampleQuestions(randomIndex),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Start Quiz",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sample questions for each quiz
  List<Map<String, dynamic>> _getSampleQuestions(int index) {
    final allQuestions = [
      // General Knowledge Quiz
      [
        {"question": "What is the capital of France?", "options": ["A. Berlin", "B. Madrid", "C. Paris", "D. Rome"], "answer": "C"},
        {"question": "How many continents are there?", "options": ["A. 5", "B. 6", "C. 7", "D. 8"], "answer": "C"},
        {"question": "Which planet is closest to the Sun?", "options": ["A. Earth", "B. Venus", "C. Mercury", "D. Mars"], "answer": "C"},
        {"question": "What is the largest ocean on Earth?", "options": ["A. Atlantic", "B. Indian", "C. Pacific", "D. Arctic"], "answer": "C"},
        {"question": "Which animal is known as the king of the jungle?", "options": ["A. Elephant", "B. Lion", "C. Tiger", "D. Bear"], "answer": "B"},
      ],
      // Geography Quiz
      [
        {"question": "What is the largest country by area?", "options": ["A. United States", "B. Canada", "C. Russia", "D. China"],"answer": "C"},
        {"question": "What is the smallest planet in our solar system?", "options": ["A. Earth", "B. Mars", "C. Mercury", "D. Venus"], "answer": "C"},
        {"question": "Who wrote the play 'Romeo and Juliet'?", "options": ["A. Charles Dickens", "B. William Shakespeare", "C. Mark Twain", "D. Jane Austen"], "answer": "B"},
        {"question": "Which planet is closest to the Sun?", "options": ["A. Earth", "B. Venus", "C. Mercury", "D. Mars"], "answer": "C"},
        {"question": "Which country is known as the Land of the Rising Sun?", "options": ["A. China", "B. Japan", "C. India", "D. South Korea"], "answer": "B"},
      ],
      // Science Quiz
      [
        {"question": "Which element has the chemical symbol 'O'?", "options": ["A. Oxygen", "B. Gold", "C. Osmium", "D. Silver"], "answer": "A"},
        {"question": "Which animal is the largest mammal on Earth?", "options": ["A. African Elephant", "B. Blue Whale", "C. Giraffe", "D. White Rhinoceros"], "answer": "B"},
        {"question": "What is the longest river in the world?", "options": ["A. Nile", "B. Amazon", "C. Yangtze", "D. Mississippi"], "answer": "A"},
        {"question": "Who painted the Mona Lisa?", "options": ["A. Leonardo da Vinci", "B. Pablo Picasso", "C. Vincent van Gogh", "D. Claude Monet"], "answer": "A"},
        {"question": "Which gas do plants absorb for photosynthesis?", "options": ["A. Oxygen", "B. Carbon Dioxide", "C. Nitrogen", "D. Hydrogen"], "answer": "B"},
      ],
      // History Quiz
      [
        {"question": "What is the capital city of Japan?", "options": ["A. Beijing", "B. Seoul", "C. Tokyo", "D. Kyoto"], "answer": "C"},
        {"question": "What is the tallest mountain in the world?", "options": ["A. Mount Kilimanjaro", "B. Mount Everest", "C. K2", "D. Mount Fuji"], "answer": "B"},
        {"question": "Which planet is known as the Red Planet?", "options": ["A. Mars", "B. Venus", "C. Jupiter", "D. Saturn"], "answer": "A"},
        {"question": "What is the main ingredient in guacamole?", "options": ["A. Tomatoes", "B. Avocados", "C. Peppers", "D. Onions"], "answer": "B"},
        {"question": "Which continent is known as the Dark Continent?", "options": ["A. Asia", "B. Africa", "C. South America", "D. Europe"], "answer": "B"},
      ],
      // Culture Quiz
      [
        {"question": "Who invented the telephone?", "options": ["A. Nikola Tesla", "B. Thomas Edison", "C. Alexander Graham Bell", "D. Guglielmo Marconi"], "answer": "C"},
        {"question": "Which country is the largest producer of coffee?", "options": ["A. Brazil", "B. Colombia", "C. Vietnam", "D. Indonesia"], "answer": "A"},
        {"question": "What is the chemical formula for water?", "options": ["A. CO2", "B. H2O", "C. O2", "D. CH4"], "answer": "B"},
        {"question": "Who was the first president of the United States?", "options": ["A. George Washington", "B. Abraham Lincoln", "C. John Adams", "D. Thomas Jefferson"], "answer": "A"},
        {"question": "Which city is known as the City of Love?", "options": ["A. Rome", "B. Paris", "C. Venice", "D. New York"], "answer": "B"},
      ],
      // Sports Quiz
      [
        {"question": "Who won the FIFA World Cup in 2018?", "options": ["A. Brazil", "B. France", "C. Germany", "D. Argentina"], "answer": "B"},
        {"question": "What is the national sport of Japan?", "options": ["A. Baseball", "B. Judo", "C. Sumo Wrestling", "D. Soccer"], "answer": "C"},
        {"question": "Which country won the first Rugby World Cup?", "options": ["A. New Zealand", "B. South Africa", "C. England", "D. Australia"], "answer": "A"},
        {"question": "Which basketball player is known as 'King James'?", "options": ["A. Michael Jordan", "B. Kobe Bryant", "C. LeBron James", "D. Shaquille O'Neal"], "answer": "C"},
        {"question": "Who holds the record for the most Olympic gold medals?", "options": ["A. Michael Phelps", "B. Usain Bolt", "C. Simone Biles", "D. Carl Lewis"], "answer": "A"},
      ],
      // Technology Quiz
      [
        {"question": "Who founded Microsoft?", "options": ["A. Steve Jobs", "B. Bill Gates", "C. Mark Zuckerberg", "D. Larry Page"], "answer": "B"},
        {"question": "What is the latest version of iOS?", "options": ["A. iOS 13", "B. iOS 14", "C. iOS 15", "D. iOS 16"], "answer": "D"},
        {"question": "What does HTTP stand for?", "options": ["A. HyperText Transfer Protocol", "B. High Tech Protocol", "C. Hyper Transfer Protocol", "D. High Tech Transfer Protocol"], "answer": "A"},
        {"question": "Which programming language is used for Android development?", "options": ["A. Swift", "B. Kotlin", "C. Java", "D. Python"], "answer": "B"},
        {"question": "Which company developed the first smartphone?", "options": ["A. Nokia", "B. Apple", "C. IBM", "D. Samsung"], "answer": "C"},
      ],
      // Literature Quiz
      [
        {"question": "Who wrote the novel '1984'?", "options": ["A. George Orwell", "B. J.K. Rowling", "C. Mark Twain", "D. Ernest Hemingway"], "answer": "A"},
        {"question": "Who is the author of 'Pride and Prejudice'?", "options": ["A. Charles Dickens", "B. Emily Dickinson", "C. William Shakespeare", "D. Jane Austen"], "answer": "D"},
        {"question": "Which of these is a work of fantasy literature?", "options": ["A. The Hobbit", "B. To Kill a Mockingbird", "C. The Great Gatsby", "D. Crime and Punishment"], "answer": "A"},
        {"question": "Who wrote 'The Catcher in the Rye'?", "options": ["A. J.D. Salinger", "B. F. Scott Fitzgerald", "C. Ernest Hemingway", "D. Mark Twain"], "answer": "A"},
        {"question": "Who is the author of 'Harry Potter'?", "options": ["A. J.R.R. Tolkien", "B. J.K. Rowling", "C. Suzanne Collins", "D. C.S. Lewis"], "answer": "B"},
      ],

      // Art & Music Quiz
      [
        {"question": "Who painted the 'Mona Lisa'?", "options": ["A. Leonardo da Vinci", "B. Vincent van Gogh", "C. Claude Monet", "D. Pablo Picasso"], "answer": "A"},
        {"question": "Which artist is famous for his 'Blue Period'?", "options": ["A. Pablo Picasso", "B. Henri Matisse", "C. Claude Monet", "D. Jackson Pollock"], "answer": "A"},
        {"question": "Who composed the 'Moonlight Sonata'?", "options": ["A. Johann Sebastian Bach", "B. Ludwig van Beethoven", "C. Wolfgang Amadeus Mozart", "D. Franz Schubert"], "answer": "B"},
        {"question": "Who painted 'The Persistence of Memory'?", "options": ["A. Salvador Dalí", "B. Rene Magritte", "C. Edvard Munch", "D. Henri Rousseau"], "answer": "A"},
        {"question": "What style of music is Ludwig van Beethoven known for?", "options": ["A. Classical", "B. Jazz", "C. Rock", "D. Baroque"], "answer": "A"},
      ],

      // Movies & TV Quiz
      [
        {"question": "Who directed 'Jurassic Park'?", "options": ["A. Steven Spielberg", "B. James Cameron", "C. Christopher Nolan", "D. Ridley Scott"], "answer": "A"},
        {"question": "What movie won the Academy Award for Best Picture in 1994?", "options": ["A. Forrest Gump", "B. The Shawshank Redemption", "C. The Godfather", "D. Schindler's List"], "answer": "A"},
        {"question": "Who played the character of Jack Dawson in 'Titanic'?", "options": ["A. Leonardo DiCaprio", "B. Brad Pitt", "C. Tom Cruise", "D. Johnny Depp"], "answer": "A"},
        {"question": "Which animated movie features the character Simba?", "options": ["A. The Lion King", "B. Aladdin", "C. Frozen", "D. Mulan"], "answer": "A"},
        {"question": "Which TV show is set in the fictional town of Hawkins, Indiana?", "options": ["A. Stranger Things", "B. The Crown", "C. Breaking Bad", "D. Game of Thrones"], "answer": "A"},
      ],
    ];

    return allQuestions[index];
  }
}
