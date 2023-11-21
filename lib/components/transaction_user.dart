import 'dart:math';

import 'package:financas_pessoais/components/transaction_form.dart';
import 'package:financas_pessoais/components/transaction_list.dart';
import 'package:financas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(id: 't1', title: 'Novo Tênis de Corrida', value: 599.90, date: DateTime.now()),
    Transaction(id: 't2', title: 'Bolo de Pote', value: 14.90, date: DateTime.now()),
    Transaction(id: 't3', title: 'Calça', value: 249.99, date: DateTime.now()),
    Transaction(id: 't4', title: 'Camiseta', value: 99.90, date: DateTime.now()),
    Transaction(id: 't5', title: 'Boné', value: 120, date: DateTime.now()),
    Transaction(id: 't6', title: 'Jogo', value: 329.99, date: DateTime.now()),
    Transaction(id: 't7', title: 'Mercado', value: 38.67, date: DateTime.now()),
    Transaction(id: 't7', title: 'Livro', value: 38.50, date: DateTime.now()),
    Transaction(id: 't7', title: 'Monitor', value: 1015.80, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(_addTransaction),
      ],
    );
  }
}
