import 'package:flutter/material.dart';

class OnboardingIllustration6 extends StatelessWidget {
  const OnboardingIllustration6({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: [
          // Background circles representing blood cells
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 30,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 40,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 50,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Heart in the center
          Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: CustomPaint(
                painter: HeartPainter(),
              ),
            ),
          ),

          // Blood vessels/arteries lines
          Positioned(
            top: 100,
            left: 60,
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 60,
            child: Container(
              width: 70,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // White blood cells
          Positioned(
            top: 40,
            right: 80,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 80,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final Path path = Path();

    // Draw heart shape
    path.moveTo(size.width / 2, size.height / 4);
    path.cubicTo(
      size.width / 4,
      0,
      0,
      size.height / 4,
      size.width / 4,
      size.height / 2,
    );
    path.cubicTo(
      size.width / 4,
      size.height * 3 / 4,
      size.width / 2,
      size.height,
      size.width / 2,
      size.height,
    );
    path.cubicTo(
      size.width / 2,
      size.height,
      size.width / 2,
      size.height,
      size.width * 3 / 4,
      size.height / 2,
    );
    path.cubicTo(
      size.width,
      size.height / 4,
      size.width * 3 / 4,
      0,
      size.width / 2,
      size.height / 4,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
