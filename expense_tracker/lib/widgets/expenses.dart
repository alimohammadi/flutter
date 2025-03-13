import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      date: DateTime.now(),
      title: "Flutter Course",
      amount: 9,
      category: Category.food,
    ),
    Expense(
      date: DateTime.now(),
      title: "Cinema",
      amount: 12.2222,
      category: Category.leisure,
    ),
    Expense(
      date: DateTime.now(),
      title: "Work",
      amount: 20,
      category: Category.work,
    )
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) => setState(
        () => _registeredExpenses.add(expense),
      );

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() => _registeredExpenses.remove(expense));

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Expense Deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() => _registeredExpenses.insert(expenseIndex, expense));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. start adding some.'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onDismissList: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
