import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends StatefulWidget {
  const BookingCalendar({Key? key}) : super(key: key);

  @override
  State<BookingCalendar> createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Stream<List<Event>> _eventsStream;

  final TextEditingController _eventController = TextEditingController();

  Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _eventsStream = _getEventsForDayStream(_selectedDay!);
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final eventsSnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    setState(() {
      _events = Map.fromIterable(eventsSnapshot.docs,
          key: (doc) => DateTime.parse(doc.id),
          value: (doc) => List<Event>.from(
              doc.data()['events'].map((json) => Event.fromJson(json, doc.id))));
    });
  }

  Stream<List<Event>> _getEventsForDayStream(DateTime day) {
    return FirebaseFirestore.instance
        .collection('events')
        .doc(_formatDateTimeToFirestoreDate(day))
        .collection('events')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromJson(doc.data(), doc.id)).toList());
  }

  String _formatDateTimeToFirestoreDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  List<Widget> _getMarkersForDay(DateTime day) {
    final List<Widget> markers = [];
    if (_events.containsKey(day) && _events[day]!.isNotEmpty) {
      markers.add(
        Positioned(
          right: 5,
          bottom: 5,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            width: 6,
            height: 6,
          ),
        ),
      );
    }
    return markers;
  }

  void _onDaySelected(DateTime selectDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectDay;
      _focusedDay = focusedDay;
      _eventsStream = _getEventsForDayStream(selectDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.purple[900],
      floatingActionButton: SingleChildScrollView(
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Add Event"),
                  content: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _eventController,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        await _addEvent();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Submit"),
                    )
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Material(
            child: SizedBox(
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 10, 16),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: _onDaySelected,
                calendarStyle: const CalendarStyle(outsideDaysVisible: false),
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    return Stack(
                      children: _getMarkersForDay(day),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Event>>(
              stream: _eventsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final events = snapshot.data!;
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            event.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () => _showEditDialog(context, event),
                          onLongPress: () => _showDeleteDialog(context, event),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addEvent() async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection('events')
        .doc(_formatDateTimeToFirestoreDate(_selectedDay!))
        .collection('events')
        .add({'title': _eventController.text});
    _events[_selectedDay]?.add(Event(_eventController.text, ref.id)); // Add event locally
    _eventController.clear();
  }

  void _showEditDialog(BuildContext context, Event event) {
    _eventController.text = event.title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text("Change Event"),
          content: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _eventController,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await _updateEvent(event.id);
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            )
          ],
        );
      },
    );
  }

  Future<void> _updateEvent(String eventId) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(_formatDateTimeToFirestoreDate(_selectedDay!))
        .collection('events')
        .doc(eventId)
        .update({'title': _eventController.text});

    setState(() {});
    _eventController.clear();
  }

  void _showDeleteDialog(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Event'),
          content: const Text('Are you sure you want to delete this event?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('events')
                    .doc(_formatDateTimeToFirestoreDate(_selectedDay!))
                    .collection('events')
                    .doc(event.id)
                    .delete();
                Navigator.of(context).pop();
                _events[_selectedDay]?.removeWhere((e) => e.id == event.id);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}

class Event {
  String title;
  final String id;

  Event(this.title, this.id);

  factory Event.fromJson(Map<String, dynamic> json, String docId) {
    return Event(json['title'], docId);
  }
}
