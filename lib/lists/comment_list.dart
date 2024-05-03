import 'package:cross/classes/comment.dart';
import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  const CommentList({super.key});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  void _addComment(String name, String comment, String url) {
    setState(() {
      comments.add(Comment(name, comment, url));
    });
  }

  void _deleteComment(int index) {
    setState(() {
      comments.removeAt(index);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Comment List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(comments[index].url)),
              title: Text(
                comments[index].name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                comments[index].description,
                style: const TextStyle(color: Colors.white),
              ),
              onLongPress: () => _deleteComment(index)
            ),
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
