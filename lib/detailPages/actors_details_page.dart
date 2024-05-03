import 'package:cross/classes/actor.dart';
import 'package:flutter/material.dart';

class ActorDetailsPage extends StatelessWidget {
  final Actor actor;

  ActorDetailsPage(this.actor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text(
            actor.name,
            style: const TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(actor.url),
            Text(
              actor.description,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
