import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:tower/pixel.dart';

import 'advert-service.dart';
import 'button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdvertService _advertService = AdvertService();
  int numberOfSquares = 130;
  List<int> piece = [];
  var direction = "left";
  List<int> landed = [10000];
  int sayac3 = 0;
  int sayac2 = 0;
  int sayac1 = 0;
  int level = 0;
  int reklamGoster = 0;
  bool basladi = false;
  bool stopbasili = false;
  bool timeriDurdur = false;

  @override
  void initState() {
    _advertService.showBanner();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  void startGame() {
    basladi = true;
    piece = [
      numberOfSquares - 3 - level * 10,
      numberOfSquares - 2 - level * 10,
      numberOfSquares - 1 - level * 10,
    ];

    Timer.periodic(Duration(milliseconds: 250), (timer1) {
      if (timeriDurdur) {
        timer1.cancel();
        timeriDurdur = false;
      }
      if (piece.first % 10 == 0) {
        direction = "right";
      } else if (piece.last % 10 == 9) {
        direction = "left";
      }
      setState(() {
        if (direction == "right") {
          for (int i = 0; i < piece.length; i++) {
            piece[i] += 1;
          }
        } else {
          for (int i = 0; i < piece.length; i++) {
            piece[i] -= 1;
          }
        }
      });

      if (level >= 2 && level < 5) {
        timer1.cancel();
        print("2");
        Timer.periodic(Duration(milliseconds: 200), (timer2) {
          //basladi = true;

          if (timeriDurdur) {
            timer2.cancel();
            timeriDurdur = false;
          }
          if (piece.first % 10 == 0) {
            direction = "right";
          } else if (piece.last % 10 == 9) {
            direction = "left";
          }
          setState(() {
            if (direction == "right") {
              for (int i = 0; i < piece.length; i++) {
                piece[i] += 1;
              }
            } else {
              for (int i = 0; i < piece.length; i++) {
                piece[i] -= 1;
              }
            }
          });
          if (level >= 5 && level < 10) {
            timer2.cancel();
            timer1.cancel();
            print("3");
            Timer.periodic(Duration(milliseconds: 160), (timer3) {
              //  basladi = true;

              if (timeriDurdur) {
                timer3.cancel();
                timeriDurdur = false;
              }
              if (piece.first % 10 == 0) {
                direction = "right";
              } else if (piece.last % 10 == 9) {
                direction = "left";
              }
              setState(() {
                if (direction == "right") {
                  for (int i = 0; i < piece.length; i++) {
                    piece[i] += 1;
                  }
                } else {
                  for (int i = 0; i < piece.length; i++) {
                    piece[i] -= 1;
                  }
                }
              });
              if (level >= 10) {
                timer3.cancel();
                timer2.cancel();
                timer1.cancel();
                print("4");
                Timer.periodic(Duration(milliseconds: 130), (timer4) {
                  //     basladi = true;
                  if (checkWinner()) {
                    _showDialog();
                    timer4.cancel();
                  }

                  if (timeriDurdur) {
                    timer4.cancel();
                    timeriDurdur = false;
                  }
                  if (piece.first % 10 == 0) {
                    direction = "right";
                  } else if (piece.last % 10 == 9) {
                    direction = "left";
                  }
                  setState(() {
                    if (direction == "right") {
                      for (int i = 0; i < piece.length; i++) {
                        piece[i] += 1;
                      }
                    } else {
                      for (int i = 0; i < piece.length; i++) {
                        piece[i] -= 1;
                      }
                    }
                  });
                });
              }
            });
          }
        });
      }
    });
  }

  bool checkWinner() {
    if (landed.last < 10) {
      return true;
    } else {
      return false;
    }
  }

  void _showKaybettiniz() {
    if (reklamGoster % 2 == 1) {
      setState(() {
        _advertService.showIntersitial();
      });
    }
    reklamGoster++;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  "LOST!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("SCORE: ${(level - 2) * 10}"),
                Lottie.asset("assets/try.json"),
              ],
            ),
            actions: [
              FlatButton(
                child: Text("RESTART"),
                onPressed: () {
                  numberOfSquares = 130;
                  piece = [];
                  direction = "left";
                  timeriDurdur = true;
                  landed = [10000];
                  level = 0;
                  Navigator.pop(context);
                  setState(() {
                    basladi = false;
                  });
                },
              ),
              FlatButton(
                child: Text("CLOSE"),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        });
  }

  void _showDialog() {
    if (reklamGoster % 2 == 1) {
      setState(() {
        _advertService.showIntersitial();
      });
    }
    reklamGoster++;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Text(
                        "Winner!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    Lottie.asset("assets/okey.json"),
                    Lottie.asset("assets/konfeti.json"),
                  ],
                ),
              ],
            ),
            actions: [
              FlatButton(
                child: Text("RESTART"),
                onPressed: () {
                  numberOfSquares = 130;
                  piece = [];
                  direction = "left";
                  landed = [10000];
                  level = 0;
                  Navigator.pop(context);
                  setState(() {
                    basladi = false;
                  });
                },
              ),
              FlatButton(
                child: Text("CLOSE"),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        });
  }

  void stack() {
    setState(() {
      stopbasili = !stopbasili;
      level++;
      for (int i = 0; i < piece.length; i++) {
        landed.add(piece[i]);
      }
      // bura hep 3 lu gelmesin mesella 4 u gecince full 2 ye dussun kutu sayısı onun icin

      if (level < 4) {
        piece = [
          numberOfSquares - 3 - level * 10,
          numberOfSquares - 2 - level * 10,
          numberOfSquares - 1 - level * 10,
        ];
      } else if (level >= 4 && level < 8) {
        piece = [
          numberOfSquares - 2 - level * 10,
          numberOfSquares - 1 - level * 10,
        ];
      } else if (level >= 8) {
        piece = [
          numberOfSquares - 1 - level * 10,
        ];
      }

      sayac1 = landed.sublist(landed.length - 3)[0];
      sayac2 = landed.sublist(landed.length - 3)[1];
      sayac3 = landed.sublist(landed.length - 3)[2];
      checkStack();
      if (level <= 4) {
        if (!landed.sublist(landed.length - 3).contains(sayac1) &&
            !landed.sublist(landed.length - 3).contains(sayac2) &&
            !landed.sublist(landed.length - 3).contains(sayac3))
          _showKaybettiniz();
      } else if (level > 4 && level <= 8) {
        if (!landed.sublist(landed.length - 2).contains(sayac2) &&
            !landed.sublist(landed.length - 2).contains(sayac3))
          _showKaybettiniz();
      } else if (level > 8) {
        if (!landed.sublist(landed.length - 1).contains(sayac3))
          _showKaybettiniz();
      }
    });
  }

  void checkStack() {
    for (int i = 0; i < landed.length; i++) {
      if (!landed.contains(landed[i] + 10) &&
          (landed[i] + 10) <= numberOfSquares - 1) {
        landed.remove(landed[i]);
      }
    }

    for (int i = 0; i < landed.length; i++) {
      if (!landed.contains(landed[i] + 10) &&
          (landed[i] + 10) <= numberOfSquares - 1) {
        landed.remove(landed[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.77,
            child: GridView.builder(
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (piece.contains(index)) {
                    return MyPixel(
                      color: Colors.red,
                    );
                  } else if (landed.contains(index)) {
                    return MyPixel(
                      color: Colors.blue,
                    );
                  } else {
                    return MyPixel(
                      color: Colors.black,
                    );
                  }
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(
                child: Text(
                  "P L A Y",
                  style: TextStyle(
                    color: basladi ? Colors.blue : Colors.white,
                    fontSize: 30,
                  ),
                ),
                function: () => basladi == false ? startGame() : null,
              ),
              MyButton(
                child: Text(
                  "S T O P",
                  style: TextStyle(
                    color: stopbasili ? Colors.red : Colors.blue,
                    fontSize: 30,
                  ),
                ),
                function: () => basladi ? stack() : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
