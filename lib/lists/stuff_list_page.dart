import 'dart:convert';
import 'package:cross/models/stuff.dart';
import 'package:cross/services/stuff_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cross/add/stuff_add_screen.dart';

class StuffsListPage extends StatefulWidget {
  const StuffsListPage({super.key});

  @override
  State<StuffsListPage> createState() => _StuffsListPageState();
}

class _StuffsListPageState extends State<StuffsListPage> {

  late Future<List<Stuff>> _stuff;
  StuffService stuffService = StuffService();

  @override
  void initState() {
    super.initState();
    _stuff = stuffService.getAllMembersOfStuff();
  }

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StuffAddScreen()));
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
      body: FutureBuilder<List<dynamic>>(
        future: _stuff,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final stuffs = snapshot.data!;
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
                        stuff['image'],
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
                            title: const Text('Удаление Стафа'),
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
                                onPressed: ()  {
                                  stuffService.deleteMemberOfStuff(stuff['id']);
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
                      Navigator.pushNamed(context, '/stuff/${stuff['id']}');
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


Future<List<dynamic>> fetchStuffs() async {
  final response = await http.get(Uri.parse('http://5.76.191.157:3000/stuff/all'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load stuffs');
  }
}
