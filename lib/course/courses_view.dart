import 'package:flutter/material.dart';
import 'package:myapp/core/wid.dart';

import '../core/theme.dart';
import 'widgets/Category_Screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController? _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _animationController = AnimationController(
          vsync: this, duration: const Duration(seconds: 2));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Categories Courses'),
            backgroundColor: Colors.blueAccent,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Courses'),
                Tab(text: 'Chemistry'),
                Tab(text: 'Abstract Books'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // First tab: Courses
              _buildCoursesTab(context),

              // Second tab: Chemistry
              _buildChemistryTab(),

              // Third tab: Abstract Books
              SizedBox(height: 90, width: 90, child: _buildAbstractBooksTab()),
            ],
          ),
        ));
  }

  // Example content for the Courses tab
  Widget _buildCoursesTab(BuildContext context) {
    final categories = [
      'Primary Education\n Stage',
      'Secondary education\n stage',
      'University Education\n Stage',
      'Abstract Books',
    ];
    final ListColor = <Color>[
      Colors.blueAccent,
      Colors.green,
      Colors.purple,
      Colors.orange,
    ];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              //width: MediaQuery.sizeOf(context).width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(category: categories[index]),
                        ),
                      );
                    },
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: ListColor[index],
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categories[index],
                          ),
                          const WavaCard(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example content for the Chemistry tab
  Widget _buildChemistryTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 350,
          height: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.black,
                width: 0.9,
              )),
          child: Center(child: Text("Will Be add soon :]",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          )),
        ),
      ],
    );
  }

  // Example content for the Abstract Books tab
  Widget _buildAbstractBooksTab() {
    return const WavaCard();
    // final double count = 9;
    // return SizedBox(
    //     width: 80,
    //     height: 120,
    //     child: WaterView(
    //       mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //           CurvedAnimation(
    //               parent: animationController!,
    //               curve: Interval((1 / count) * 7, 1.0,
    //                   curve: Curves.fastOutSlowIn))),
    //       mainScreenAnimationController: animationController,
    //     ));
    // const Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Icon(Icons.book, size: 80, color: Colors.purple),
    //       SizedBox(height: 20),
    //       Text(
    //         'Abstract books coming soon!',
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class WavaCard extends StatelessWidget {
  const WavaCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.110,
      height: MediaQuery.sizeOf(context).height * 0.190,
      decoration: BoxDecoration(
        color: HexColor('#E8EDFE'),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(80.0),
            bottomLeft: Radius.circular(80.0),
            bottomRight: Radius.circular(80.0),
            topRight: Radius.circular(80.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: FitnessAppTheme.grey.withOpacity(0.4),
              offset: const Offset(2, 2),
              blurRadius: 4),
        ],
      ),
      child: const WaveView(
        percentageValue: 60.0,
      ),
    );
  }
}
