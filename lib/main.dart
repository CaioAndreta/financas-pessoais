import 'dart:io';
import 'dart:math';

import 'package:financas_pessoais/components/chart.dart';
import 'package:financas_pessoais/components/transaction_form.dart';
import 'package:financas_pessoais/components/transaction_list.dart';
import 'package:financas_pessoais/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(const DespesasApp());

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.pinkAccent,
            onPrimary: Colors.white,
            secondary: Colors.amber,
            onSecondary: Colors.indigo.shade900,
            surface: const Color.fromRGBO(254, 254, 254, 1),
            primaryContainer: Colors.pinkAccent,
            onPrimaryContainer: Colors.black,
          ),
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.pinkAccent),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
          )),
          textTheme: tema.textTheme.copyWith(
            titleLarge: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).textScaler.scale(20),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleMedium: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).textScaler.scale(16),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleSmall: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).textScaler.scale(12),
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
            ),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          listTileTheme: const ListTileThemeData(
            tileColor: Color.fromRGBO(240, 240, 240, 1),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(id: 't0', title: 'Conta antiga', value: 10000, date: DateTime.now().subtract(const Duration(days: 33))),
    // Transaction(
    //     id: 't1',
    //     title: 'Novo Tênis de Corrida',
    //     value: 599.90,
    //     date: DateTime.now().subtract(const Duration(days: 0))),
    // Transaction(id: 't2', title: 'Bolo de Pote', value: 14.90, date: DateTime.now().subtract(const Duration(days: 1))),
    // Transaction(id: 't3', title: 'Calça', value: 249.99, date: DateTime.now().subtract(const Duration(days: 4))),
    // Transaction(id: 't4', title: 'Calça', value: 100, date: DateTime.now().subtract(const Duration(days: 0))),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) => element.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  _addTransaction(String title, double value, DateTime? date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date!,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: () => fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: () => fn,
            icon: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
            _showChart ? Icons.list : Icons.bar_chart_rounded, () => setState(() => _showChart = !_showChart)),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add, () => _openTransactionFormModal(context))
    ];
    final appBar = AppBar(title: const Text('Despesas Pessoais'), actions: actions);
    final availableHeight =
        MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(height: availableHeight * (isLandscape ? 0.65 : 0.3), child: Chart(_recentTransactions)),
            if (!_showChart || !isLandscape)
              SizedBox(height: availableHeight * 0.7, child: TransactionList(_transactions, _deleteTransaction)),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: actions),
            ),
            child: bodyPage)
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              onPressed: () => _openTransactionFormModal(context),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
  }
}
