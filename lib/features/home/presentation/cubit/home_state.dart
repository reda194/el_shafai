part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeCategorySelected extends HomeState {
  final String selectedCategory;

  const HomeCategorySelected({required this.selectedCategory});

  @override
  List<Object> get props => [selectedCategory];
}

class HomeSearchActive extends HomeState {
  final String query;

  const HomeSearchActive({required this.query});

  @override
  List<Object> get props => [query];
}
