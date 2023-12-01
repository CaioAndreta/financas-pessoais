import 'package:financas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function(String) onDelete;
  const TransactionItem(this.transaction, this.onDelete, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(child: Text('R\$${transaction.value}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                onPressed: () => onDelete(transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Excluir'),
              )
            : IconButton(
                onPressed: () => onDelete(transaction.id),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
      ),
    );
  }
}
