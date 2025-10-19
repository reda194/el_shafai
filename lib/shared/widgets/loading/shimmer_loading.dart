import 'package:flutter/material.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double? width;
  final double height;
  final int lines;

  const ShimmerCard({
    super.key,
    this.width,
    this.height = 100,
    this.lines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(lines, (index) {
          final lineWidth = index == 0
              ? 0.8
              : index == 1
                  ? 0.6
                  : 0.4;
          return Container(
            margin: EdgeInsets.only(bottom: index < lines - 1 ? 8 : 0),
            height: 16,
            width: width != null
                ? width! * lineWidth
                : double.infinity * lineWidth,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }
}
