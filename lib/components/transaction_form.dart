import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm(this.onSubmit, {super.key});

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: valueController,
            decoration: InputDecoration(labelText: 'Valor (R\$)'),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: ElevatedButton.styleFrom(foregroundColor: Colors.purple),
                onPressed: () => onSubmit(titleController.text, double.tryParse(valueController.text) ?? 0.0),
                child: const Text('Nova Transação'),
              ))
        ]),
      ),
    );
  }
}
