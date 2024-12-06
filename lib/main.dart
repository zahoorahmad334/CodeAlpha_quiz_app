import 'package:flutter/material.dart';
import 'package:quiz_app/questions.dart';
import 'package:quiz_app/utils/constant/background_color.dart';
import 'package:quiz_app/utils/theme/custom_theme/elevated_button_theme.dart';

void main() => runApp(const FlashcardApp());

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      ),
      themeMode: ThemeMode.system,
      home: const FlashcardHome(),
    );
  }
}

class FlashcardHome extends StatelessWidget {
  const FlashcardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonFontSize = screenWidth * 0.05;
    final buttonHeight = screenHeight * 0.08;

    return Scaffold(
      appBar: AppBar(title: const Text('Flashcard Quiz')),
      body: BackgroundColor(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuestionScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: buttonFontSize),
                      backgroundColor: Colors.blue.withOpacity(0.7),
                      minimumSize: Size(
                        double.infinity,
                        buttonHeight,
                      ),
                    ),
                    child: const Text('Start Quiz'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
