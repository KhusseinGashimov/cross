import 'package:cross/classes/News.dart';
import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  NewsDetailPage(this.news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(news.clickbait,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(
                height: 30,
              ),
              Image.network(news.url),
              const SizedBox(
                height: 30,
              ),
              Text(
                news.description,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
