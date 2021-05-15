import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:confetti/confetti.dart';

// import 'dart:math';

QuizBrain quizBrain = QuizBrain();
List<Widget> response = [];

String useAns;

int score = 0;
void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Quizzler(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => ShowResponse(),
      },
    ),
  );
}

void list() {
  response.add(Padding(
    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 400,
        color: Colors.white60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              tileColor: Colors.black12,
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        // color: Colors.pink,
                        width: double.infinity,
                        child: Text(
                          '$questionsSaver',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: double.infinity,
                      // color: Colors.purple,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Correct answer: ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('$answersSaver',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  ConfettiController myController;
  // @override
  // void initState() {
  //   super.initState();
  //   myController = ConfettiController(duration: Duration(seconds: 1));
  // }

  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: true,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    backgroundColor: Colors.grey.shade900,
    animationDuration: Duration(milliseconds: 500),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: Colors.black,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.orange,
    ),
    alertAlignment: Alignment.center,
  );
  List<Icon> scoreKeeper = [];
  int score = 0;
  void counter() {
    score = score + 1;
  }

  void checkAnswer(bool userInput) {
    bool correctAnswer = quizBrain.getAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        quess++;
        if (userInput == correctAnswer) {
          counter();
          scoreKeeper.add(
            Icon(CupertinoIcons.checkmark, color: Colors.green),
          );
        }
        Alert(
            context: context,
            title: 'Thank',
            style: alertStyle,
            desc: 'score= $score /$mm',
            buttons: [
              DialogButton(
                color: Colors.orange,
                child: Text(
                  "Check correct answers",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShowResponse()));
                },
                width: 200,
              ),
            ]).show();
        quizBrain.reset();
        scoreKeeper = [];
        score = 0;
      } else {
        if (userInput == correctAnswer) {
          print('Correct');
          counter();
          scoreKeeper.add(
            Icon(CupertinoIcons.checkmark, color: Colors.green),
          );
        } else {
          print('wrong');
          scoreKeeper.add(
            Icon(CupertinoIcons.xmark, color: Colors.red),
          );
        }
        quizBrain.nextQuestion();
      }
    });
    // if (userInput == correctAnswer) {
    //   print('correct');
    //   score++;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Text(
                  "$quess/$mm",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
          // Center(
          //   child: ConfettiWidget(
          //     confettiController: myController,
          //     blastDirection: pi / 2,
          //     maxBlastForce: 100,
          //     minBlastForce: 80,
          //     emissionFrequency: 0.04,
          //     numberOfParticles: 7,
          //     blastDirectionality: BlastDirectionality.explosive,
          //     // particleDrag: 0.01,
          //     gravity: .5,
          //     colors: const [
          //       Colors.green,
          //       Colors.blue,
          //       Colors.pink,
          //       Colors.orange,
          //       Colors.purple
          //     ],

          //     // minimumSize: const Size(10, 10),
          //     // maximumSize: const Size(40, 40),
          //   ),
          // ),

          //         Container(
          //           height: 550,
          //           child: Center(
          //             child: Text(
          //               quizBrain.getQuestionText(),
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontSize: 18.0,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          // // color: Colors.black,
          //           margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          //           padding: EdgeInsets.fromLTRB(0, 160, 0, 160),
          //           decoration: BoxDecoration(
          //             border: Border.all(
          //               color: Colors.transparent,
          //               style: BorderStyle.solid,
          // // width: 1.0,
          //             ),
          //             color: Colors.black26,
          //             borderRadius: BorderRadius.circular(14.0),
          //           ),
          //         ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                list();
              },
            ),
          )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                list();
              },
            ),
          )),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: scoreKeeper)),
          // children: scoreKeeper,
        ],
      ),
    );
  }
}

class ShowResponse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          backgroundColor: CupertinoColors.secondarySystemFill,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Check Responses',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                response = [];
              },
              child: Icon(CupertinoIcons.backward)),
        ),
        body: Scrollbar(
          child: Center(
            child: SafeArea(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: response)),
            ),
          ),
        ),
      ),
    );
  }
}
