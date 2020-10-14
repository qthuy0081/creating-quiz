import 'package:creating_quiz/screenquiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    App()
  );
}

class App extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "ProductSans"
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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
                "Quiz",
                style: TextStyle(
                  color: Color(0xFFA20CBE),
                  fontSize: 90
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
                    "Play",
                    style: TextStyle(
                      fontSize: 33,

                      ),
                  ),
                  color: Color(0xFFFFBA00),
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