import 'package:flutter/material.dart';
import 'package:neurocare_app/shared/widgets/loading/shimmer_loading.dart';

class SkeletonLoader extends StatelessWidget {
  final int itemCount;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext, int) itemBuilder;

  const SkeletonLoader({
    super.key,
    this.itemCount = 5,
    this.spacing = 12,
    this.padding,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding ?? const EdgeInsets.all(20),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: itemBuilder,
    );
  }
}

class DoctorCardSkeleton extends StatelessWidget {
  const DoctorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: const Row(
        children: [
          // Avatar
          ShimmerLoading(
            width: 60,
            height: 60,
            borderRadius: 30,
          ),

          SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Name
                ShimmerLoading(
                  width: 120,
                  height: 16,
                ),
                SizedBox(height: 4),
                // Specialty
                ShimmerLoading(
                  width: 80,
                  height: 14,
                ),
                SizedBox(height: 8),
                // Rating and button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoading(
                      width: 80,
                      height: 32,
                      borderRadius: 16,
                    ),
                    Row(
                      children: [
                        ShimmerLoading(
                          width: 12,
                          height: 12,
                          borderRadius: 6,
                        ),
                        SizedBox(width: 4),
                        ShimmerLoading(
                          width: 30,
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentCardSkeleton extends StatelessWidget {
  const AppointmentCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Doctor info
          Row(
            children: [
              ShimmerLoading(
                width: 40,
                height: 40,
                borderRadius: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ShimmerLoading(
                      width: 100,
                      height: 16,
                    ),
                    SizedBox(height: 4),
                    ShimmerLoading(
                      width: 80,
                      height: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Date and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading(
                width: 60,
                height: 14,
              ),
              ShimmerLoading(
                width: 80,
                height: 14,
              ),
            ],
          ),

          SizedBox(height: 12),

          // Status and action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading(
                width: 100,
                height: 32,
                borderRadius: 16,
              ),
              ShimmerLoading(
                width: 80,
                height: 32,
                borderRadius: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
