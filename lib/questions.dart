import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quiz_app/result.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  QuestionScreenState createState() => QuestionScreenState();
}

class QuestionScreenState extends State<QuestionScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> flashcards = [
    {
      'question': 'What is Flutter?',
      'choices': [
        'A database management tool',
        'A UI toolkit for building natively compiled apps',
        'A programming language',
        'An operating system'
      ],
      'answer': 1
    },
    {
      'question': 'What language does Flutter use?',
      'choices': ['Python', 'Java', 'Dart', 'C++'],
      'answer': 2
    },
    {
      'question': 'Who developed Flutter?',
      'choices': ['Microsoft', 'Apple', 'Google', 'Amazon'],
      'answer': 2
    },
    {
      'question': 'What is a widget in Flutter?',
      'choices': [
        'A building block of the Flutter UI',
        'A database entity',
        'A backend service',
        'An HTTP request'
      ],
      'answer': 0
    },
    {
      'question': 'What does setState() do in Flutter?',
      'choices': [
        'Compiles the code',
        'Rebuilds the widget with updated data',
        'Runs the app',
        'Handles exceptions'
      ],
      'answer': 1
    },
    {
      'question': 'What is hot reload in Flutter?',
      'choices': [
        'Restarting the app',
        'Updating the app without losing its state',
        'Clearing app cache',
        'Recompiling the app'
      ],
      'answer': 1
    },
    {
      'question': 'Which of these is a state management solution for Flutter?',
      'choices': ['Redux', 'GetX', 'Provider', 'All of the above'],
      'answer': 3
    },
    {
      'question': 'What file contains app dependencies in a Flutter project?',
      'choices': ['pubspec.yaml', 'config.json', 'manifest.xml', 'index.html'],
      'answer': 0
    },
    {
      'question': 'Which widget is used to align its child within itself?',
      'choices': ['Column', 'Row', 'Align', 'Scaffold'],
      'answer': 2
    },
    {
      'question': 'What is the purpose of the MaterialApp widget?',
      'choices': [
        'To define app-level settings',
        'To render widgets',
        'To compile Dart code',
        'To create HTTP requests'
      ],
      'answer': 0
    },
    {
      'question': 'Which function is the entry point of a Flutter app?',
      'choices': ['main()', 'start()', 'initialize()', 'runApp()'],
      'answer': 0
    },
    {
      'question': 'What is the difference between StatelessWidget and StatefulWidget?',
      'choices': [
        'StatelessWidget cannot change its state',
        'StatefulWidget cannot change its state',
        'StatelessWidget is only for mobile apps',
        'StatefulWidget is only for web apps'
      ],
      'answer': 0
    },
    {
      'question': 'What is the default build system for Flutter?',
      'choices': ['Maven', 'Gradle', 'Bazel', 'CMake'],
      'answer': 1
    },
    {
      'question': 'Which widget allows scrolling for a long list of items?',
      'choices': ['ListView', 'Container', 'GridView', 'PageView'],
      'answer': 0
    },
    {
      'question': 'What is the purpose of the Scaffold widget?',
      'choices': [
        'To provide a basic visual layout structure',
        'To create animations',
        'To fetch API data',
        'To handle device permissions'
      ],
      'answer': 0
    },
    {
      'question': 'Which of these is not a valid Flutter widget?',
      'choices': ['Text', 'Column', 'Button', 'Dropdown'],
      'answer': 3
    },
    {
      'question': 'What is the default text style for Text widgets in Flutter?',
      'choices': ['Bold', 'Italic', 'Normal', 'Underline'],
      'answer': 2
    },
    {
      'question': 'Which package is commonly used for state management in Flutter?',
      'choices': ['FlutterStore', 'Bloc', 'Flux', 'None'],
      'answer': 1
    },
    {
      'question': 'Which of these is used for creating animations in Flutter?',
      'choices': ['AnimationController', 'StatelessWidget', 'StatefulWidget', 'StreamBuilder'],
      'answer': 0
    },
    {
      'question': 'Which of these are valid types of navigation in Flutter?',
      'choices': ['Navigator.push', 'Navigator.pop', 'Navigator.pushNamed', 'All of the above'],
      'answer': 3
    },
  ];

  late List<Map<String, dynamic>> shuffledFlashcards;
  int currentIndex = 0;
  int score = 0;

  // Animation Controllers
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _restartQuiz();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation
    _colorAnimation = ColorTween(
      begin: Colors.blue, // Starting color
      end: Colors.purple, // Ending color
    ).animate(_controller);
  }

  void _restartQuiz() {
    shuffledFlashcards = flashcards.map((flashcard) {
      List<String> choices = List<String>.from(flashcard['choices']);
      int correctAnswerIndex = flashcard['answer'];

      Map<String, int> shuffledData = _shuffleChoices(choices, correctAnswerIndex);

      return {
        'question': flashcard['question'],
        'choices': choices,
        'answer': shuffledData['newAnswerIndex']!,
      };
    }).toList();
    shuffledFlashcards.shuffle();
    currentIndex = 0;
    score = 0;
  }

  Map<String, int> _shuffleChoices(List<String> choices, int correctAnswerIndex) {
    String correctAnswer = choices[correctAnswerIndex];
    choices.shuffle(Random());
    int newAnswerIndex = choices.indexOf(correctAnswer);
    return {'newAnswerIndex': newAnswerIndex};
  }

  void nextFlashcard(int selectedIndex) {
    setState(() {
      if (selectedIndex == shuffledFlashcards[currentIndex]['answer']) score++;
      currentIndex++;
      if (currentIndex >= shuffledFlashcards.length) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: score)),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust sizes dynamically based on screen width
    final questionFontSize = screenWidth * 0.05;
    final choiceButtonHeight = screenHeight * 0.08;
    final choiceButtonFontSize = screenWidth * 0.03;

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _colorAnimation.value!,
                  Colors.orange,
                ],
              ),
            ),
            child: currentIndex < shuffledFlashcards.length
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${currentIndex + 1}. ${shuffledFlashcards[currentIndex]['question']}',
                    style: TextStyle(
                      fontSize: questionFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...(shuffledFlashcards[currentIndex]['choices'] as List<String>)
                      .asMap()
                      .entries
                      .map((entry) {
                    int idx = entry.key;
                    String choice = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: choiceButtonHeight,
                        child: ElevatedButton(
                          onPressed: () => nextFlashcard(idx),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: choiceButtonFontSize),
                          ),
                          child: Text(choice),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
