import 'package:cross/lists/actor_list.dart';
import 'package:cross/classes/comment.dart';
import 'package:cross/lists/comment_list.dart';
import 'package:cross/classes/news.dart';
import 'package:cross/detailPages/news_detail_page.dart';

import 'package:cross/lists/news_list.dart';

import 'package:cross/lists/stuff_list_page.dart';
import 'package:cross/pages/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final videoURL =
      "https://www.youtube.com/watch?v=5PSNL1qE6VY&t=142s&pp=ygUOYXZhdGFyIHRyYWlsZXI%3D";

  late YoutubePlayerController _controller;
  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false, enableCaption: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
                child: IconButton(
              icon: const Icon(Icons.calendar_month),
              color: Colors.white,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (contex)=>const BookingCalendar()));
              }
            )),
          )
        ],
      ),
      backgroundColor: Colors.purple[900],
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
            height: 20,
          ),
          const Text(
            "DESCRIPTION",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Enter the World of Pandora. In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 200,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Ink.image(
                          image: NetworkImage(newss[0].url),
                          height: 200,
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailPage(newss[0])));
                            },
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 70,
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            newss[0].clickbait,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 200,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Ink.image(
                          image: NetworkImage(newss[1].url),
                          height: 200,
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailPage(newss[1])));
                            },
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 70,
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            newss[1].clickbait,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 200,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Ink.image(
                          image: NetworkImage(newss[2].url),
                          height: 200,
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailPage(newss[2])));
                            },
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 70,
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            newss[2].clickbait,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewsListPage()));
            },
            child: const Text("View All News"),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ActorsListPage()));
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
                            builder: (context) => const StuffListPage()));
                  },
                  child: const Text('Stuff',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ))),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Comments",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                color: Colors.purple[700],
                child: ListTile(
                  title: Text(comments[0].name),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(comments[0].description),
                  ),
                  subtitleTextStyle: const TextStyle(color: Colors.white),
                  titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const CommentList()));
                  },
                  child: const Text(
                    "View all",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
