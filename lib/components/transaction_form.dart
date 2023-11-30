import 'package:financas_pessoais/components/adaptative_button.dart';
import 'package:financas_pessoais/components/adaptative_date_picker.dart';
import 'package:financas_pessoais/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime?) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              AdaptativeTextField(
                controller: titleController,
                label: 'Título',
                onSubmit: (_) => _submitForm(),
              ),
              AdaptativeTextField(
                controller: valueController,
                label: 'Valor (R\$)',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSubmit: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              Align(
                  alignment: Alignment.centerRight,
                  child: AdaptativeButton(
                    onPressed: _submitForm,
                    label: 'Nova Transação',
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
