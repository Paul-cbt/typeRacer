import 'package:flutter/material.dart';
import 'package:coursedefrappe/typeracer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String version = "alpha 0.2";
  String explication = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xf5121212),
      appBar: AppBar(
        backgroundColor: const Color(0xaa303331),
        title: Text("Course de vitesse de frappe"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
                      child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  TypeRace(),
                  FlatButton(
                      onPressed: () {
                        if (explication == ""){

                        
                        setState(() {
                          explication =
                              "Appuyez sur \"commencer\", puis recopiez le texte dans la case en dessous. Votre temps et vos erreurs seront comptés afin de vous donner votre vitesse de frappe";
                        });
                      }else{
                        setState(() {
                          explication ="";
                        });
                      }
                      },
                      child: Text(
                        "comment jouer?",
                        style: TextStyle(color: Colors.purple[500]),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6 < 600
                          ? MediaQuery.of(context).size.width * 0.6
                          : 600,
                      child: Text(
                        explication,
                        style: TextStyle(color: Colors.white),
                      )),
                  
                  
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Text(version, style: TextStyle(color: Colors.white),),
      )
    );
  }
}
