import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expenses_list.dart';
import 'package:expenses_app/widgets/new_expense.dart';
import 'package:expenses_app/widgets/chart/chart.dart';

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
      builder: (ctx) => NewExpenseForm(onAddExpense: _addNewExpense),
    );
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    int index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Gasto eliminado'),
        duration: const Duration(milliseconds: 700),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No hay gastos registrados'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
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
      body: width < 600
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Theme.of(context).colorScheme.surface,
                  margin: Theme.of(context).cardTheme.margin,
                  child: Center(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Theme.of(context).colorScheme.surface,
                    margin: Theme.of(context).cardTheme.margin,
                    child: mainContent,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Theme.of(context).colorScheme.surface,
                  margin: Theme.of(context).cardTheme.margin,
                  child: Center(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Theme.of(context).colorScheme.surface,
                    margin: Theme.of(context).cardTheme.margin,
                    child: mainContent,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
    );
  }
}
