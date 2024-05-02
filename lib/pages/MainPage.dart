import 'package:cross/pages/ActorList.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final videoURL = "https://www.youtube.com/watch?v=YMx8Bbev6T4";

  late YoutubePlayerController _controller;
  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Avatar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23)),
                  Text(
                    "Directed by",
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  const Text(
                    "James Cameron",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  )
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Actors",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                  Text(
                    "Sam Worthington",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  Text(
                    "Zoe Saldana",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Enter the World of Pandora. In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActorsListPage()));
                  },
                  child: const Text(
                    'Actor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActorsListPage()));
                  },
                  child: const Text('Stuff',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ))),
            ],
          )
        ],
      ),
    );
  }
}
