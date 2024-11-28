import 'package:flutter/material.dart';

class LessonDetailsScreen extends StatefulWidget {
  final String lesson;

  LessonDetailsScreen({required this.lesson});

  @override
  _LessonDetailsScreenState createState() => _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends State<LessonDetailsScreen> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final lessonDetails = {
      'title': widget.lesson,
      'description': 'This is a detailed description of the lesson.',
      'duration': '45 minutes',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${lessonDetails['title']}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${lessonDetails['description']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Duration: ${lessonDetails['duration']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isFavorited = !isFavorited;
                });
              },
              icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
              label: Text(isFavorited ? 'Remove from Favorites' : 'Add to Favorites'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
