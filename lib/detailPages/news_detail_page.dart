import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross/edit/news_edit_screen.dart';
import 'package:flutter/material.dart';

class NewsDetailsPage extends StatelessWidget {
  final String docId;
  const NewsDetailsPage({
    super.key,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('newss').doc(docId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...", style: TextStyle(color: Colors.white));
            }
            if (!snapshot.hasData || snapshot.data!.exists == false) {
              return const Text("No Data", style: TextStyle(color: Colors.white));
            }
            var newsData = snapshot.data!;
            return Text(newsData['name'], style: const TextStyle(color: Colors.white));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsEditScreen(documentId: docId),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('newss').doc(docId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.exists == false) {
            return const Center(child: Text("No data available"));
          }
          var newsData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.network(
                  newsData['url'],
                  errorBuilder: (context, error, stackTrace) {
                    // Default image if there is an error loading the image
                    return Image.network(
                      "https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/1a697a67-d844-42ba-b367-071c4a581462/280x420",
                      fit: BoxFit.cover,
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  newsData['description'],
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
