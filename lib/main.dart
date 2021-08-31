import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udemy_project_2/widgets/chart.dart';
import 'package:flutter_udemy_project_2/widgets/new_transaction.dart';
import 'package:flutter_udemy_project_2/widgets/transcation_list.dart';

import 'models/transaction.dart';

void main() {
 /*
 // for enable portrait mode
 WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          // errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionClass> _userTransaction = [
/* TransactionClass(
      id: 't1',
      title: 'New Shoes',
      amount: 660.0,
      date: DateTime.now(),
    ),
    TransactionClass(
      id: 't2',
      title: 'New Shop',
      amount: 660000.0,
      date: DateTime.now(),
    ),
    TransactionClass(
      id: 't3',
      title: 'New Cup',
      amount: 60.0,
      date: DateTime.now(),
    ),*/
  ];

  List<TransactionClass> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = TransactionClass(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Personal Expense App"),
      actions: [
        IconButton(
          onPressed: () => startAddNewTransaction(context),
          icon: Icon(Icons.add),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(_userTransaction, deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
