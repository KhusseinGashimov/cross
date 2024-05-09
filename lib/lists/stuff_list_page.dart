import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross/detailPages/stuff_details_page.dart';
import 'package:cross/pages/stuff_add_screen.dart';
import 'package:flutter/material.dart';

class StuffsListPage extends StatelessWidget {
  const StuffsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const StuffAddScreen()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          "Список стаффа",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('stuffs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final stuffs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: stuffs.length,
              itemBuilder: (context, index) {
                final stuff = stuffs[index];
                final name = stuff['name'];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: ListTile(
                    title: Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        stuff['url'],
                        errorBuilder: (context, error, stackTrace) {
                          // Изображение по умолчанию при ошибке загрузки
                          return Image.network(
                              "https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/1a697a67-d844-42ba-b367-071c4a581462/280x420",
                              width: 60,
                              height: 60);
                        },
                      ),
                    ),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Удаление актера'),
                            content: const Text(
                                'Вы уверены, что хотите удалить этого стаффа?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Отмена'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Закрыть диалог без удаления
                                },
                              ),
                              TextButton(
                                child: const Text('Удалить'),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('stuffs')
                                      .doc(stuff.id)
                                      .delete();
                                  Navigator.of(context)
                                      .pop(); // Закрыть диалог после удаления
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StuffDetailsPage(
                            docId: stuff.id,
                            name: stuff['name'], // Передача имени актера
                            url: stuff['url'], // Передача URL изображения
                            description: stuff[
                                'description'], // Передача описания актера
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
