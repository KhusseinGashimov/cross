import 'package:cross/pages/Actor.dart';
import 'package:cross/pages/ActorsDetailsPage.dart';
import 'package:flutter/material.dart';

class ActorsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          "Список актеров",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: ListView.builder(
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(actors[index].Url)),
              title: Text(
                actors[index].name,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActorDetailsPage(actors[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
