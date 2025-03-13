import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount =
        double.tryParse(_amountController.text); //tryParse('Hello') => null

    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // ========== Validate field ==========
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content: Text(
            'Please make sure a valid title, amount, date and category was entered',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            )
          ],
        ),
      );

      return;
    }

    var expenseData = Expense(
      date: _selectedDate!,
      title: _titleController.text,
      amount: double.tryParse(_amountController.text)!,
      category: _selectedCategory,
    );

    widget.onAddExpense(expenseData);
    Navigator.pop(context);
  }

  void _percenstDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text(
                'Title',
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 50,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _percenstDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(
                  () => _selectedCategory = value!,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text("Save Expense"),
              )
            ],
          )
          // DropdownButton(items: items, onChanged: onChanged)
        ],
      ),
    );
  }
}
