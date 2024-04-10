import 'package:expense_tracker/database/expense_database.dart';
import 'package:expense_tracker/extension/datetime_extension.dart';
import 'package:expense_tracker/extension/double_extension.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    context.read<ExpenseDatabase>().readExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>(
      builder: (BuildContext context, ExpenseDatabase value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Expense Tracker'),
          ),
          body: ListView.builder(
            itemCount: value.expenses.length,
            itemBuilder: (context, index) {
              final Expense expense = value.expenses[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => {},
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () => context.push('/edit', extra: {'expense': expense}),
                    title: Text(expense.name),
                    subtitle: Text(expense.date.formatDate()),
                    trailing: Text(expense.amount.formatAmount()),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showNewExpenseDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('New Expense'),
            contentPadding: const EdgeInsets.all(16),
            content: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'amount',
                      decoration: const InputDecoration(labelText: 'Amount'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    FormBuilderDateTimePicker(
                      name: 'date',
                      inputType: InputType.date,
                      decoration: const InputDecoration(labelText: 'Date'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ],
                )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.saveAndValidate()) {
                    // Save the expense
                    final Expense expense = Expense(
                      name: _formKey.currentState!.value['name'],
                      amount: double.parse(_formKey.currentState!.value['amount']),
                      date: _formKey.currentState!.value['date'],
                    );
                    await context.read<ExpenseDatabase>().createExpense(expense);
                    debugPrint('Expense ${expense.toString()} saved');
                    context.pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ));
}
