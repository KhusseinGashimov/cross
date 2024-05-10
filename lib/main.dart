import 'package:cross/detailPages/actors_details_page.dart';
import 'package:cross/detailPages/news_detail_page.dart';
import 'package:cross/detailPages/stuff_details_page.dart';
import 'package:cross/lists/actor_list.dart';
import 'package:cross/lists/comment_list.dart';
import 'package:cross/lists/news_list.dart';
import 'package:cross/lists/stuff_list_page.dart';
import 'package:cross/pages/booking_calendar.dart';
import 'package:cross/pages/login_page.dart';
import 'package:cross/pages/main_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Handle the dynamic route for stuff details
        if (settings.name!.startsWith('/stuff/')) {
          final stuffId =
              settings.name!.substring(7); // Extracts the ID from the route
          return MaterialPageRoute(
            builder: (context) => StuffDetailsPage(docId: stuffId),
          );
        }
        if (settings.name!.startsWith('/actor/')) {
          final actorId =
              settings.name!.substring(7); // Extracts the ID from the route
          return MaterialPageRoute(
            builder: (context) => ActorDetailsPage(docId: actorId),
          );
        }

        if (settings.name!.startsWith('/news/')) {
          final newsId =
              settings.name!.substring(6); // Extracts the ID from the route
          return MaterialPageRoute(
            builder: (context) => NewsDetailsPage(docId: newsId),
          );
        }
        
        // Fallback for defined static routes
        var routes = <String, WidgetBuilder>{
          '/': (context) => const MainPage(),
          '/stuffs': (context) => const StuffsListPage(),
          '/actors': (context) => const ActorsListPage(),
          '/comments': (context) => const CommentList(),
          '/newss': (context) => const NewssListPage(),
          '/calendar': (context) => const BookingCalendar(),
        };

        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: Colors.purple[900]),
        scaffoldBackgroundColor: Colors.purple[900],
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const LoginScreen();
          }

          return const MainPage(); // MainPage now serves as the root route '/'
        },
      ),
    );
  }
}
