import 'package:expense_tracker/model/category.dart';
import 'package:isar/isar.dart';

part 'expense.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement;
  final String name;
  final category = IsarLink<Category>();
  final double amount;
  final DateTime date;

  Expense({required this.name, required this.amount, required this.date});

  @override
  String toString() {
    return 'Expense(name: $name, amount: $amount, date: $date)';
  }
}
