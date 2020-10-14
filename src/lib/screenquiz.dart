import 'dart:async';
import 'dart:convert';

import 'package:creating_quiz/QuizHelper.dart';
import 'package:creating_quiz/ResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String apiURL = "https://opentdb.com/api.php?amount=10&category=18";

  QuizHelper quizHelper;

  int currentQuiz = 0;

  int totalSecond = 30;
  int elapsedSecond = 0;

  Timer timer;

  int totalScore = 0;
  @override
  void initState() {
    // TODO: implement initState
    fecthAllQuizzes();
    super.initState();
  }

  void fecthAllQuizzes() async {
    var res = await http.get(apiURL);
    var body = res.body;

    print(body);
    var json = jsonDecode(body);

    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper.results[currentQuiz].incorrectAnswers
          .add(quizHelper.results[currentQuiz].correctAnswer);
      quizHelper.results[currentQuiz].incorrectAnswers.shuffle();
    });
    initTimer();
  }

  void checkAnswer(answer) {
    String correctAnswer = quizHelper.results[currentQuiz].correctAnswer;
    if (answer == correctAnswer) {
      totalScore += 1;
    } else {
      print("fail");
    }
    changeQuestion();
  }

  void changeQuestion() {
    timer.cancel();
    if(currentQuiz == quizHelper.results.length -1) {
      print("quiz completed");
      Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (context) => ResultScreen(score: totalScore,),)
      );
    } else {
      setState(() {
        currentQuiz += 1;

      });
      quizHelper.results[currentQuiz].incorrectAnswers
          .add(quizHelper.results[currentQuiz].correctAnswer);
      quizHelper.results[currentQuiz].incorrectAnswers.shuffle();
      initTimer();
    }
  }

  void initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSecond) {
        print("Time up");
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapsedSecond = t.tick;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (quizHelper != null) {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage("assets/icon-circle.png"),
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        "$elapsedSecond",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Q. ${quizHelper.results[currentQuiz].question}",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontFamily: "ProductSans"),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Column(
                      children: quizHelper.results[currentQuiz].incorrectAnswers
                          .map((option) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: RaisedButton(
                        onPressed: () => {checkAnswer(option)},
                        color: Color(0xFF511AA8),
                        colorBrightness: Brightness.dark,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          option,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "ProductSans",
                              color: Colors.white),
                        ),
                      ),
                    );
                  }).toList()),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
