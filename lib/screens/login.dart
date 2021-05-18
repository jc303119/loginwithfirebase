import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:loginwithfirebase/screens/todolist.dart';
import '../utils/constants.dart';
import '../models/user.dart';
import '../utils/db.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String msg = '';
  _register() {
    User user = new User(userid.text, pwd.text);
    Future<DocumentReference> docRef = Db.addUser(user);
    docRef.then((result) {
      setState(() {
        msg = 'Result is $result';
      });
      Future<QuerySnapshot> future = Db.readAllRecords();
      future.then((snapShot) {
        snapShot.documents
            .forEach((record) => print(record.data)); //record.data
      }).catchError((e) => print("Error during Record print $e"));
      print('Result is $result');
    }).catchError((e) {
      setState(() {
        msg = 'Error while add $e';
      });
      print('Error during Add $e');
    });
  }

  TextEditingController userid = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                  // color: Colors.blueAccent,
                  width: media.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register $msg',
                        style: TextStyle(fontSize: 30, color: Colors.redAccent),
                      ),
                      Image.network(
                        Constants.loginImage,
                        height: media.width / 1.5,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        //color: Colors.pink,
                        child: TextField(
                          controller: userid,
                          decoration: InputDecoration(
                            hintText: 'Type User ID here',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        //color: Colors.pink,
                        child: TextField(
                          controller: pwd,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Type Password here',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: media.width * .5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: FlatButton(
                                  onPressed: () {
                                    _register();
                                  },
                                  child: Text('Register'),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: media.width * .5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: FlatButton(
                                  onPressed: () {
                                    // moveToViewPage();
                                  },
                                  child: Text('View Records'),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Image.network(
                                  'https://cdn.iconscout.com/icon/premium/png-256-thumb/facebook-social-like-network-50190.png'),
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3, color: Colors.blueAccent)),
                            ),
                            Container(
                              child: Image.network(
                                  'https://lh3.googleusercontent.com/proxy/7fLfkc4uoDIyfZDyEOvLvc7-3fOsZj_TK3ACZvh6T9rtxXaxRrxspr3-KEIPy_gK1PItt1fT6OOTSlkNVM3fmqMvWp4wBiNm0SwEKcFllg9jUdocMaLZO9ei4KWGlL0Ilw'),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3, color: Colors.blueAccent)),
                            )
                          ],
                        ),
                      ),
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
      ),
    );
  }

//  void moveToViewPage() {
//    Navigator.push(context, MaterialPageRoute(builder: (c)=>ToDoList()));
//  }
}
