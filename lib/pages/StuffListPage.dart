import 'package:cross/pages/Stuff.dart';
import 'package:cross/pages/StuffDetailsPage.dart';
import 'package:flutter/material.dart';

class StuffListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          "Список Stuff",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: ListView.builder(
        itemCount: stuffs.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(stuffs[index].url)),
              title: Text(
                stuffs[index].name,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                stuffs[index].crew,
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StuffDetailsPage(stuffs[index]),
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
