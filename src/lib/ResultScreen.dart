import 'package:creating_quiz/screenquiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ResultScreen extends StatelessWidget {

  final int score;
  ResultScreen({this.score});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark
      )
    );
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image(
                  image: AssetImage("assets/icon-circle.png"),
                  width: 300,
                  height: 300,
                ),
              ),
              Text(
                "RESULT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35
                ),
              ),
              Text(
                "$score/10",
                style: TextStyle(
                  color: Color(0xFFFFBA00),
                  fontSize: 60
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 30
                ),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20
                  ),
                  onPressed: ()=>{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> QuizScreen())
                    )
                  },
                  child: Text(
                    "TRY AGAIN",
                    style: TextStyle(
                      fontSize: 33,

                      ),
                  ),
                  color: Color(0xFFFFBA00),
                  textColor: Colors.white

                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 30
                ),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20
                  ),
                  onPressed: ()=>{
                    Navigator.pop(context)
                  },
                  child: Text(
                    "EXIT",
                    style: TextStyle(
                      fontSize: 33,

                      ),
                  ),
                  color: Color(0xFF511AA8),
                  textColor: Colors.white

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

