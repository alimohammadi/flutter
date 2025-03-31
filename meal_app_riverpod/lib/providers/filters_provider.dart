import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/screens/filters.dart';

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.gluteneFree: false,
          Filter.lactoseFree: false,
          Filter.vegen: false,
          Filter.vegetarian: false,
        });

  void setFilters(Map<Filter, bool> chosenFilter) {
    state = chosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[Filter]= isActive; => not allowed! => mutating state
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);
