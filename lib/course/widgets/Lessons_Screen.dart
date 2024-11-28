import 'package:flutter/material.dart';

import 'Lesson_Details.dart';

class LessonsScreen extends StatelessWidget {
  final String course;

  LessonsScreen({required this.course});

  @override
  Widget build(BuildContext context) {
    final lessons = ['Lesson 1', 'Lesson 2', 'Lesson 3'];

    return Scaffold(
      appBar: AppBar(
        title: Text('$course Lessons'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailsScreen(lesson: lessons[index]),
                  ),
                );
              },
              child: Card(
                elevation: 8,
                margin: EdgeInsets.symmetric(vertical: 8),
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    lessons[index],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
