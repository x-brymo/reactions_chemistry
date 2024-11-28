import 'package:flutter/material.dart';

import 'Lesson_Details.dart';

class FavoriteLessonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteLessons = ['Lesson 1', 'Lesson 3'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Lessons'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: favoriteLessons.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailsScreen(lesson: favoriteLessons[index]),
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
                    favoriteLessons[index],
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
