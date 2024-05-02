import 'package:cross/pages/Actor.dart';
import 'package:flutter/material.dart';

class ActorDetailsPage extends StatelessWidget {
  final Actor actor;

  ActorDetailsPage(this.actor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(actor.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(actor.description),
      ),
    );
  }
}
