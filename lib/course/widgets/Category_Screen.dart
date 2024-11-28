import 'package:flutter/material.dart';

import 'Lessons_Screen.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final grades = [
      'Grade 1',
      'Grade 2',
      'Grade 3',
    ];
    final term = [
      'First Term',
      'Second Term',
    ];
    final courses = ['Math', 'Science', 'English'];
    final ListColor1 = <Color>[

      Color(0xff94C5F6),
      Color(0xffFF2AEF),
    ];
    final ListColor2 = <Color>[
      Color(0xfff4d03f),
      Color(0xff16a085),
    ];
    final ListColor3 = <Color>[
      Color(0xffFFDDE1),
      Color(0xffEE9CA7),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Courses'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: grades.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonsScreen(course: courses[index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  width: 160,
                  
                  decoration: BoxDecoration(

                   gradient: LinearGradient(colors: 
                      ListColor2,
                    begin: Alignment.bottomRight,
                    end: Alignment.center,
                   // stops: const [0.0, 0.5, 1.0]
                   ),
                    borderRadius: BorderRadius.circular(16),
                
                  ),
                  child: ListTile(
                     // contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        grades[index],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                           " term[index]",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          LinearProgressIndicator(
                            value: 0.15,
                          )
                        ],
                      ),
                      trailing: Text("N/N")
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
