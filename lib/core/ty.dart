import 'dart:math';
import 'package:flutter/material.dart';


class WaveContainer extends StatefulWidget {
  @override
  _WaveContainerState createState() => _WaveContainerState();
}

class _WaveContainerState extends State<WaveContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double waterLevel = 0.5; // نسبة الماء بين 0 و 1
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))
      ..repeat(reverse: true); // تكرار الحركة بشكل مستمر
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wave Container Example")),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // حاوية الأنبوبة
            Container(
              width: 200,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 2),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.blue.shade500],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: WavePainter(_controller.value, waterLevel),
                  );
                },
              ),
            ),
            // إضافة زر لتغيير نسبة الماء
            Positioned(
              bottom: 30,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // زيادة مستوى الماء
                    waterLevel = (waterLevel + 0.1) % 1.1; // تغيير نسبة الماء
                  });
                },
                child: Text('زيادة نسبة الماء'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final double waterLevel;

  WavePainter(this.animationValue, this.waterLevel);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    Path path = Path();

    // رسم الموجة مع الاهتزاز
    path.moveTo(0, size.height - waterLevel * size.height);
    for (double i = 0; i < size.width; i++) {
      // إضافة حركة الموجة باستخدام دالة sin والـ animationValue
      double y = size.height - waterLevel * size.height + sin((i + animationValue * 2 * pi) / 20) * 20;
      path.lineTo(i, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // رسم الموجة
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
