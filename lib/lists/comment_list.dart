import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  const CommentList({super.key});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  void _addComment(String name, String comment, String url) {
  setState(() {
    // Create a new document in the 'comments' collection with the given data
    FirebaseFirestore.instance.collection('comments').add({
      'name': name,
      'comment': comment,
      'url': url,
      'timestamp': FieldValue.serverTimestamp(), // Adds a server-side timestamp
    });
  });
}

void _updateComment(String id, String newName, String newComment, String url) {
  FirebaseFirestore.instance.collection('comments').doc(id).update({
    'name': newName,
    'comment': newComment,
    'url': url, // Assuming you want to allow the URL to be changed in the future
  });
}



  void _deleteComment(String id) {
  setState(() {
    FirebaseFirestore.instance.collection('comments').doc(id).delete();
  });
}


  void _showAddCommentDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a Comment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    hintText: 'Comment',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addComment(nameController.text, commentController.text,
                    "https://cdn-icons-png.flaticon.com/512/6596/6596121.png");
                Navigator.of(context).pop();
              },
              child: const Text('Add Comment'),
            ),
          ],
        );
      },
    );
  }

void _showEditCommentDialog(String id, String currentName, String currentComment, String currentUrl) {
  TextEditingController nameController = TextEditingController(text: currentName);
  TextEditingController commentController = TextEditingController(text: currentComment);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Comment'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  hintText: 'Comment',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _updateComment(id, nameController.text, commentController.text, currentUrl);
              Navigator.of(context).pop();
            },
            child: const Text('Update Comment'),
          ),
        ],
      );
    },
  );
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: const BackButton(color: Colors.white),
      title: const Text('Comment List', style: TextStyle(color: Colors.white)),
    ),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('comments').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var comment = snapshot.data!.docs[index];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(comment['url']),
                ),
                title: Text(
                  comment['name'],
                  style: const TextStyle(
                      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  comment['comment'],
                  style: const TextStyle(color: Colors.white),
                ),
                onLongPress: () => _deleteComment(comment.id), // Update to use Firestore document ID
                onTap: ()=> _showEditCommentDialog(comment.id, comment['name'], comment['comment'], comment['url']),
              ),
            );
          },
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _showAddCommentDialog,
      tooltip: 'Add Comment',
      child: const Icon(Icons.add),
    ),
  );
}

}
