import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  static Future<void> initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: directory.path);
  }

  Future<void> createExpense(Expense expense) async {
    await isar.writeTxn(() => isar.expenses.put(expense));
    _expenses.add(expense);
    readExpenses();
  }

  Future<void> readExpenses() async {
    final List<Expense> expenses = await isar.expenses.where(sort: Sort.asc).findAll();

    _expenses.clear();
    _expenses.addAll(expenses);
    notifyListeners();
  }

  Future<void> updateExpense(int id, Expense updatedExpense) async {
    updatedExpense.id = id;
    await isar.writeTxn(() => isar.expenses.put(updatedExpense));
    await readExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() => isar.expenses.delete(id));
    await readExpenses();
  }
}
