import 'package:flutter/material.dart';

import 'package:coursedefrappe/quotelist.dart';
import 'package:coursedefrappe/random.dart';

class TypeRace extends StatefulWidget {
  @override
  _TypeRaceState createState() => _TypeRaceState();
}

class _TypeRaceState extends State<TypeRace> {
  RichText richtext;
  int number = 0;
  String starttext = "commencer";
  String value;
  var _controller = TextEditingController();
  String currentcharacter = "";
  int pos = 0;
  String finaltext = "";
  int errors = 0;
  double speed = 0;
  String speeddisplay = "0";
  bool istimerrunning = false;
  bool isgamerunning = false;
  bool isgameover = false;
  double pourcentageerreurs;
  int pourcentageerreursarrondi;

  Stopwatch chrono = new Stopwatch();
  int nblettres = 0;

  String textToSplit = "";
  var spans = new List<TextSpan>();

  _TypeRaceState({this.richtext});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.45),
            color: Colors.transparent,
            child: Container(
              decoration: new BoxDecoration(
                  color: Color(0xaa303331),
                  borderRadius: new BorderRadius.all(
                    const Radius.circular(20.0),
                  )),
              //height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.7 < 800
                  ? MediaQuery.of(context).size.width * 0.7
                  : 800,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.2),
                      child: Text(
                        isgameover
                            ? "$finaltext, erreurs : $pourcentageerreursarrondi %"
                            : finaltext,
                        //finaltext =="bravo"? TextAlign.center :TextAlign.justify,
                        style: TextStyle(
                            color: isgameover
                                ? Colors.purple[400]
                                : Color(0xfff9f7f7),
                            fontFamily: "Montserrat",
                            fontSize: 20),
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7 < 500
                ? MediaQuery.of(context).size.width * 0.7
                : 500,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "erreurs: $errors",
                      style: TextStyle(
                          color: Colors.purple[400],
                          fontFamily: "Montserrat",
                          fontSize: 24),
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                          color: Colors.purple[400],
                          fontFamily: "Montserrat",
                          fontSize: 24),
                    ),
                    Text(
                      "vitesse: $speeddisplay",
                      style: TextStyle(
                          color: Colors.purple[400],
                          fontFamily: "Montserrat",
                          fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      color: Colors.purple[500],
                      onPressed: () {
                        final splittedText = textToSplit.split("");

                        for (int i = 0; i <= splittedText.length - 1; i++) {
                          spans.add(TextSpan(
                            text: splittedText[i].toString() + " ",
                            style: TextStyle(
                                color: Color(0xfff9f7f7),
                                fontFamily: "Montserrat",
                                fontSize: 20),
                          ));
                        }
                        setState(() {
                          starttext = "recommencer";
                          pos = 0;
                          finaltext = quotes[randomnumber()].text;
                          //finaltext = "test";

                          _controller.clear();
                          errors = 0;
                          if (istimerrunning) {
                            chrono.stop();
                            istimerrunning = false;
                            chrono.reset();
                          }
                          chrono.stop();
                          istimerrunning = false;
                          chrono.reset();
                          nblettres = 0;
                          speed = 0;
                          speeddisplay = "0";
                          isgamerunning = true;
                          isgameover = false;
                          _controller.clear();
                        });
                      },
                      child: Text(
                        starttext,
                        style: TextStyle(
                            color: Color(0xfff9f7f7),
                            fontFamily: "Montserrat",
                            fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.purple)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            //height: MediaQuery.of(context).size.height * 0.4,
            color: Colors.transparent,
            child: Container(
              decoration: new BoxDecoration(
                  color: Color(0xaa303331),
                  borderRadius: new BorderRadius.all(
                    const Radius.circular(20.0),
                  )),
              //height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.6 < 600
                  ? MediaQuery.of(context).size.width * 0.6
                  : 600,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Text(
                        this.currentcharacter,
                        style: TextStyle(
                            color: Color(0xfff9f7f7),
                            fontFamily: "Montserrat",
                            fontSize: 20),
                      ),
                      TextField(
                        enabled: isgamerunning ? true : false,
                        controller: _controller,
                        showCursor: false,
                        autofocus: true,
                        style: TextStyle(color: Colors.transparent),
                        onChanged: (text) {
                          if (!istimerrunning) {
                            chrono.start();
                            istimerrunning = true;
                          }
                          currentcharacter = text;

                          setState(() {
                            if (text == finaltext[pos] || text == "4221") {
                              //4221 is a cheat code
                              nblettres += 1;
                              if (finaltext.length > 1 && text != "4221") {
                                finaltext = finaltext.substring(1);

                                if (nblettres > 1) {
                                  speed = (nblettres / 5) /
                                      (chrono.elapsedMicroseconds *
                                          0.000000016667);
                                  //formula for calculating speed
                                  speeddisplay =
                                      speed.toString().substring(0, 2);
                                }
                              } else if (text == "4221") {
                                currentcharacter = "";
                                isgameover = true;
                                pourcentageerreurs = errors / nblettres * 100;
                                pourcentageerreursarrondi =
                                    pourcentageerreurs.toInt();
                                finaltext =
                                    "c'est pas comme ca qu'on s'améliore...";
                                return;
                              } else {
                                currentcharacter = "";
                                isgameover = true;
                                pourcentageerreurs = errors / nblettres * 100;
                                pourcentageerreursarrondi =
                                    pourcentageerreurs.toInt();
                                if (pourcentageerreurs < 5) {
                                  finaltext = "excellent";
                                } else if (pourcentageerreurs < 20) {
                                  finaltext = "bravo";
                                } else {
                                  finaltext =
                                      "il faut continuer à s'entrainer!";
                                }

                                isgamerunning = false;
                                starttext = "nouvelle partie";
                              }
                            } else {
                              if (text == "c" && finaltext[pos] == "ç") {
                                nblettres += 1;

                                if (finaltext.length > 1) {
                                  finaltext = finaltext.substring(1);

                                  if (nblettres > 1) {
                                    speed = (nblettres / 5) /
                                        (chrono.elapsedMicroseconds *
                                            0.000000016667);
                                    //formula for calculating speed
                                    speeddisplay =
                                        speed.toString().substring(0, 2);
                                  }
                                }
                              } else if (text == "C" && finaltext[pos] == "Ç") {
                                nblettres += 1;
                                if (finaltext.length > 1) {
                                  finaltext = finaltext.substring(1);

                                  if (nblettres > 1) {
                                    speed = (nblettres / 5) /
                                        chrono.elapsed.inMinutes;
                                  }
                                }
                              }
                              if (text == "i" && finaltext[pos] == "ï") {
                                nblettres += 1;

                                if (finaltext.length > 1) {
                                  finaltext = finaltext.substring(1);

                                  if (nblettres > 1) {
                                    speed = (nblettres / 5) /
                                        (chrono.elapsedMicroseconds *
                                            0.000000016667);
                                    speeddisplay =
                                        speed.toString().substring(0, 2);
                                  }
                                }
                              } else if (text == "I" && finaltext[pos] == "Ï") {
                                nblettres += 1;
                                if (finaltext.length > 1) {
                                  finaltext = finaltext.substring(1);

                                  if (nblettres > 1) {
                                    speed = (nblettres / 5) /
                                        chrono.elapsed.inMinutes;
                                  }
                                }
                              } else {
                                errors += 1;
                              }
                            }
                          });

                          _controller.clear();
                        },
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
