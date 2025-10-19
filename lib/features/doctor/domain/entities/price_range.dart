import 'package:equatable/equatable.dart';

class PriceRange extends Equatable {
  final double start;
  final double end;

  const PriceRange({
    required this.start,
    required this.end,
  });

  @override
  List<Object> get props => [start, end];

  @override
  String toString() {
    return 'PriceRange(start: $start, end: $end)';
  }
}
