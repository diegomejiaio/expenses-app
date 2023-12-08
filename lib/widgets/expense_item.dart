import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Theme.of(context).cardTheme.margin,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expense.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  categorIcons[expense.category].toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('- S/ ${expense.amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodySmall),
                const Spacer(),
                const SizedBox(width: 50),
                Text(expense.formattedDate,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            )
          ],
        ),
      ),
    );
  }
}
