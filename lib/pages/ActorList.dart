import 'package:cross/pages/Actor.dart';
import 'package:cross/pages/ActorsDetailsPage.dart';
import 'package:flutter/material.dart';

class ActorsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Список актеров")),
      body: ListView.builder(
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(actors[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActorDetailsPage(actors[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}