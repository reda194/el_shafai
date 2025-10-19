import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  void selectCategory(String category) {
    emit(HomeCategorySelected(selectedCategory: category));
  }

  void clearCategorySelection() {
    emit(const HomeInitial());
  }

  void searchDoctors(String query) {
    emit(HomeSearchActive(query: query));
  }

  void clearSearch() {
    emit(const HomeInitial());
  }
}
