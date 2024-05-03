import 'package:cross/classes/stuff.dart';
import 'package:flutter/material.dart';

class StuffDetailsPage extends StatelessWidget {
  final Stuff stuff;

  const StuffDetailsPage(this.stuff, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text(
            stuff.name,
            style: const TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(stuff.url),
            Text(
              stuff.description,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
