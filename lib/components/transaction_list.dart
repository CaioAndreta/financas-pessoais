import 'package:financas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDelete;

  const TransactionList(this.transactions, this.onDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Nenhuma Transação Cadastrada!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final e = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(child: Text('R\$${e.value}')),
                      ),
                    ),
                    title: Text(
                      e.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(DateFormat('d MMM y').format(e.date)),
                    trailing: IconButton(
                      onPressed: () => onDelete(e.id),
                      icon: const Icon(Icons.delete),
                    )),
              );
            },
          );
  }
}
