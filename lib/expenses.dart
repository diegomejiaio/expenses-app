import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expenses_list.dart';
import 'package:expenses_app/widgets/new_expense.dart';

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
        title: 'Medicinas de mi mama',
        amount: 100.00,
        date: DateTime.now(),
        category: Category.comida),
    Expense(
        title: 'Uber a la oficina',
        amount: 50.00,
        date: DateTime.now(),
        category: Category.transporte),
    Expense(
        title: 'Nuevo teclado',
        amount: 2000.00,
        date: DateTime.now(),
        category: Category.trabajo),
    Expense(
        title: 'Viaje a Tarapoto',
        amount: 1000.00,
        date: DateTime.now(),
        category: Category.diversion),
  ];

  void _openAddExpenseModal() {
    showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return const NewExpenseForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis gastos'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseModal,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(80.0),
              child: Center(
                child: Text('Gastos Chart'),
              ),
            ),
          ),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
