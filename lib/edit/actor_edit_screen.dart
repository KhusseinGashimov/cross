import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActorEditScreen extends StatefulWidget {
  final String
      documentId; // Assuming each actor has a unique Firestore document ID

  const ActorEditScreen({super.key, required this.documentId});

  @override
  _ActorEditScreenState createState() => _ActorEditScreenState();
}

class _ActorEditScreenState extends State<ActorEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    var document =
        FirebaseFirestore.instance.collection('actors').doc(widget.documentId);
    var snapshot = await document.get();
    if (snapshot.exists) {
      _nameController.text = snapshot.data()?['name'] ?? '';
      _urlController.text = snapshot.data()?['url'] ?? '';
      _descriptionController.text = snapshot.data()?['description'] ?? '';
    }
  }

  void _updateData() {
    FirebaseFirestore.instance
        .collection('actors')
        .doc(widget.documentId)
        .update({
      'name': _nameController.text,
      'url': _urlController.text,
      'description': _descriptionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text(_nameController.text,
            style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.amber)),
              style: const TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                  labelText: 'Image URL',
                  labelStyle: TextStyle(color: Colors.amber)),
              style: const TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.amber)),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateData,
              child: const Text('Update Details'),
            ),
          ],
        ),
      ),
    );
  }
}
