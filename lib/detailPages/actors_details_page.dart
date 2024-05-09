import 'package:cross/pages/actor_edit_screen.dart';
import 'package:flutter/material.dart';

class ActorDetailsPage extends StatelessWidget {
  final String docId;
  final String name;
  final String url;
  final String description;

  const ActorDetailsPage({
    super.key,
    required this.docId,
    required this.name,
    required this.url,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ActorEditScreen(documentId: docId)));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(url, errorBuilder: (context, error, stackTrace) {
              // Изображение по умолчанию при ошибке загрузки
              return Image.network(
                  "https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/1a697a67-d844-42ba-b367-071c4a581462/280x420");
            }),
            Text(
              description,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
