import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cross/detailPages/actors_details_page.dart';
import 'package:cross/detailPages/news_detail_page.dart';
import 'package:cross/detailPages/stuff_details_page.dart';
import 'package:cross/firebase_options.dart';
import 'package:cross/lists/actor_list.dart';
import 'package:cross/lists/comment_list.dart';
import 'package:cross/lists/news_list.dart';
import 'package:cross/lists/stuff_list_page.dart';
import 'package:cross/pages/booking_calendar.dart';
import 'package:cross/pages/login_page.dart';
import 'package:cross/pages/main_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

);
  runApp(const ProviderScope(child: MyApp()),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Handle the dynamic route for stuff details
        // if (settings.name!.startsWith('/stuff/')) {
        //   final stuffId = settings.name!.substring(7); // Extracts the ID from the route
        //   return MaterialPageRoute(
        //     builder: (context) => StuffDetailsPage(docId: stuffId),
        //   );
        // }
        if (settings.name!.startsWith('/actor/')) {
          final actorId = settings.name!.substring(7); // Extracts the ID from the route
          return MaterialPageRoute(
            builder: (context) => ActorDetailsPage(docId: actorId),
          );
        }
        if (settings.name!.startsWith('/news/')) {
          final newsId = settings.name!.substring(6); // Extracts the ID from the route
          return MaterialPageRoute(
            builder: (context) => NewsDetailsPage(docId: newsId),
          );
        }
        
        // Fallback for defined static routes
        var routes = <String, WidgetBuilder>{
          '/': (context) => const MainPage(),
          '/stuffs': (context) => StaffListPage(),
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

// Пример функции для аутентификации
Future<void> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print('Login successful');
  } else {
    throw Exception('Failed to login');
  }
}

// Пример функции для получения списка бронирований
Future<void> fetchBookings() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/bookings'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> bookings = jsonDecode(response.body);
    print('Bookings: $bookings');
  } else {
    throw Exception('Failed to fetch bookings');
  }
}

// Пример функции для получения списка актеров
Future<void> fetchActors() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/actors'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> actors = jsonDecode(response.body);
    print('Actors: $actors');
  } else {
    throw Exception('Failed to fetch actors');
  }
}

// Пример функции для получения списка комментариев
Future<void> fetchComments() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/comments'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> comments = jsonDecode(response.body);
    print('Comments: $comments');
  } else {
    throw Exception('Failed to fetch comments');
  }
}

// Пример функции для получения новостей
Future<void> fetchNews() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/news'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> news = jsonDecode(response.body);
    print('News: $news');
  } else {
    throw Exception('Failed to fetch news');
  }
}

// Пример функции для получения списка вещей
Future<void> fetchStuff() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/stuff'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> stuff = jsonDecode(response.body);
    print('Stuff: $stuff');
  } else {
    throw Exception('Failed to fetch stuff');
  }
}
