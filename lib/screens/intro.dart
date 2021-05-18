import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginwithfirebase/screens/login.dart';
import '../utils/constants.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  moveToLoginPage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: media.height,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                top: 400,
                child: Image.network(
                  Constants.bottomLeftCorner,
                  height: media.height * .5,
                ),
              ),
              Container(
                width: media.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ToDo App',
                      style: TextStyle(fontSize: 30, color: Colors.redAccent),
                    ),
                    Image.network(Constants.mainImage),
                    Container(
                      width: media.width * .6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: FlatButton(
                          onPressed: () {
                            moveToLoginPage(context);
                          },
                          child: Text('Register'),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          color: Colors.blueAccent,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                child: Image.network(
                  Constants.topLeftCorner,
                  height: media.height * .5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
