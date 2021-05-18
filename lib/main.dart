import 'package:flutter/material.dart';
import 'package:loginwithfirebase/screens/todolist.dart';
import './screens/intro.dart';

void main() {
  runApp(MaterialApp(
    title: 'ToDo App',
    debugShowCheckedModeBanner: false,
    home: Intro(),
    //home: ToDoList(),
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}
