import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onDismissList,
  });

  final List<Expense> expenses;

  final void Function(Expense expense) onDismissList;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context);

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, indx) => Dismissible(
        key: ValueKey(expenses[indx]),
        background: Container(
          color: scheme.colorScheme.error,
          margin: EdgeInsets.symmetric(
            horizontal: scheme.cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onDismissList(expenses[indx]);
        },
        child: ExpenseItem(
          expense: expenses[indx],
        ),
      ),
    );
  }
}
