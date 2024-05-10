import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference actorsCollection =
      FirebaseFirestore.instance.collection('actors');

  final CollectionReference stuffsCollection =
      FirebaseFirestore.instance.collection('stuffs');

  final CollectionReference newssCollection =
      FirebaseFirestore.instance.collection('newss');
  Future<void> addActor(String name, String description, String url) async {
    try {
      await actorsCollection.add({
        'name': name,
        'description': description,
        'url': url,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addStuff(String name, String description, String url) async {
    try {
      await stuffsCollection.add({
        'name': name,
        'description': description,
        'url': url,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addNews(String name, String description, String url) async {
    try {
      await newssCollection.add({
        'name': name,
        'description': description,
        'url': url,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
