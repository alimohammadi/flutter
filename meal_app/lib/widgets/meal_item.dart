import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;

  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    final rareComplexityText = meal.complexity.name;

    return rareComplexityText[0].toUpperCase() +
        rareComplexityText.substring(1);
  }

  String get affordabilityText {
    final rareAffordabilityText = meal.complexity.name;

    return rareAffordabilityText[0].toUpperCase() +
        rareAffordabilityText.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge, // Prevents overflow
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage(
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image,
                      size: 100, color: Colors.red);
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
