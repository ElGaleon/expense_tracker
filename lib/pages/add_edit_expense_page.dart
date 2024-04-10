import 'package:expense_tracker/database/expense_database.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/ui/layout/spaced_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddEditExpensePage extends StatefulWidget {
  final Expense? expense;
  bool get isEditing => expense != null;
  const AddEditExpensePage({super.key, this.expense});

  @override
  State<AddEditExpensePage> createState() => _AddEditExpensePageState();
}

class _AddEditExpensePageState extends State<AddEditExpensePage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      debugPrint('Editing expense: ${widget.expense!.toString()}');
      _formKey.currentState?.fields['name']?.setValue(widget.expense!.name);
      _formKey.currentState?.fields['amount']?.setValue(widget.expense!.amount.toString());
      _formKey.currentState?.fields['date']?.setValue(widget.expense!.date);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.expense != null ? const Text('Edit Expense') : const Text('Add Expense'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            key: _formKey,
            initialValue: {
              'name': widget.expense?.name,
              'amount': widget.expense?.amount.toString(),
              'date': widget.expense?.date,
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SpacedColumn(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 16,
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
                ),
                FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final Expense expense = Expense(
                          name: _formKey.currentState!.value['name'],
                          amount: double.parse(_formKey.currentState!.value['amount']),
                          date: _formKey.currentState!.value['date'],
                        );
                        if (widget.isEditing) {
                          expense.id = widget.expense!.id;
                          context.read<ExpenseDatabase>().updateExpense(expense.id, expense);
                          debugPrint('Expense ${expense.toString()} updated');
                        } else {
                          context.read<ExpenseDatabase>().createExpense(expense);
                          debugPrint('Expense ${expense.toString()} saved');
                        }
                        context.pop();
                      }
                    },
                    child: const Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
