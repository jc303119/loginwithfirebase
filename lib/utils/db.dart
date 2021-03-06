import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginwithfirebase/models/task.dart';
import '../models/user.dart';

class Db {
  static final dbReference = Firestore.instance;
  static Future<DocumentReference> addUser(User user) {
    CollectionReference userCollection = dbReference.collection("users");
    Future<DocumentReference> future = userCollection.add(user.convertToMap());
    return future;
  }

  static Future<DocumentReference> addTask(Task task) {
    CollectionReference userCollection = dbReference.collection("todo");
    Future<DocumentReference> future = userCollection.add(task.convertToMap());
    return future;
  }

  static Future<void> updateTask(String id, Task task) {
    CollectionReference userCollection = dbReference.collection("todo");
    Future<void> future =
        userCollection.document(id).updateData(task.convertToMap());
    return future;
  }

  static Future<QuerySnapshot> readAllRecords() {
    CollectionReference userCollection = dbReference.collection("users");
    Future<QuerySnapshot> querySnapShot = userCollection.getDocuments();
    return querySnapShot;
  }

  static Stream<QuerySnapshot> getAllRecordsOfToDo() {
    return dbReference.collection('todo').snapshots();
  }

  static Future<QuerySnapshot> getAllRecordsForFuture() {
    return dbReference.collection('todo').getDocuments();
  }

  static deleteMarkRecords(List<String> ids) {
    ids.forEach((id) {
      dbReference.collection('todo').document(id).delete();
    });
  }
}
