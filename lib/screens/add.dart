import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginwithfirebase/models/task.dart';
import '../utils/db.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  BuildContext builtCtx;
  var selectedDateValue = "";
  TextEditingController taskNameCtrl = TextEditingController();
  TextEditingController taskDescCtrl = TextEditingController();

  _showDialog() {
    var media = MediaQuery.of(builtCtx).size;
    return AlertDialog(
      title: Text('Add Dialog Box'),
      backgroundColor: Colors.greenAccent,
      elevation: 5,
      content: Container(
        height: media.height / 3,
        child: Column(
          children: <Widget>[
            Text(
              'Record Added Successfully',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Icon(
            Icons.close,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(builtCtx).pop();
          },
        )
      ],
    );
  }

  void saveToDb() {
    print("In add Function..... ");
    Task task = new Task(taskNameCtrl.text, taskDescCtrl.text);
    task.date = selectedDateValue;
    Future<DocumentReference> future = Db.addTask(task);
    future
        .then((ref) =>
            {showDialog(context: builtCtx, builder: (ctx) => _showDialog())})
        .catchError((err) {
      print('Error in Add $err');
    });
  }

  chooseDate(BuildContext ctx) {
    Future<DateTime> dateTime = showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010, 1),
        lastDate: DateTime(2030, 1));
    dateTime.then((selectedDate) {
      setState(() {
        selectedDateValue = selectedDate.toString();
      });
    }).catchError((err) {});
  }

  goToBackPage() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    builtCtx = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.yellowAccent,
          ),
          onPressed: () {
            goToBackPage();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'Type Task Name', hintText: 'Task Name'),
              controller: taskNameCtrl,
            ),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: 'Type Desc Here', hintText: 'Description'),
              controller: taskDescCtrl,
            ),
            Row(
              children: <Widget>[
                Text(selectedDateValue),
                RaisedButton(
                  onPressed: () {
                    chooseDate(context);
                  },
                  child: Icon(
                    Icons.calendar_today,
                    size: 30,
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                saveToDb();
              },
            )
          ],
        ),
      ),
    );
  }
}
