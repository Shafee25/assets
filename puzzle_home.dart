import 'package:flutter/material.dart';
import 'model/puzzle.dart';

class PuzzleApp extends StatefulWidget {
  const PuzzleApp({super.key});

  @override
  State<PuzzleApp> createState() => _PuzzleAppState();
}

class _PuzzleAppState extends State<PuzzleApp> {
  int _currentPuzzleIndex = 0;

  List puzzleBank = [
    Puzzle.name("I teach ICT", true),
    Puzzle.name("I Know Geography", false),
    Puzzle.name("We went India", false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Puzzle App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "images/img.png",
                width: 300,
                height: 300,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.blue.shade700,
                  style: BorderStyle.solid,
                ),
              ),
              height: 100.0,
              width: 400.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  puzzleBank[_currentPuzzleIndex].puzzleText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _prevPuzzle(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _checkPuzzle(true, context),
                  child: Text(
                    "True",
                    style: TextStyle(
                      color: Colors.blue.shade300,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _checkPuzzle(false, context),
                  child: Text(
                    "False",
                    style: TextStyle(
                      color: Colors.blue.shade300,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _nextPuzzle(),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _checkPuzzle(bool userPuzzleChoice, BuildContext context) {
    final isCorrect =
        userPuzzleChoice == puzzleBank[_currentPuzzleIndex].answer;
    final snackBar = SnackBar(
      content: Text(isCorrect ? "Correct" : "Incorrect"),
      backgroundColor: isCorrect ? Colors.green : Colors.red,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _nextPuzzle() {
    setState(() {
      _currentPuzzleIndex = (_currentPuzzleIndex + 1) % puzzleBank.length;
    });
  }

  void _prevPuzzle() {
    setState(() {
      _currentPuzzleIndex =
          (_currentPuzzleIndex - 1 + puzzleBank.length) % puzzleBank.length;
    });
  }
}
