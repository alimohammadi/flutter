import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStates(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((item) => item.id == meal.id).toList();
    } else {
      state = [...state, meal];
    }

    return !mealIsFavorite;
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
