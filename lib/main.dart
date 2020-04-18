import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './widgets/TransactionForm.dart';
import './widgets/UpdateTransactionForm.dart';
import './widgets/TransactionCardsList.dart';
import './widgets/OneWeekChartBars.dart';

import './models/Transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Scaffold(
        body: MyHomePage(
          title: 'Expenses Tracker',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;

  MyHomePage({this.title = "Demo app"});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> tx_list = [];

  void _addTransaction(String title, double amount, DateTime selected_date) {
    Transaction tx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selected_date, //DateTime.now(),
    );

    setState(() {
      tx_list.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      //isScrollControlled: true,
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          child: TransactionForm(_addTransaction),
        );
      },
    );
  }

  List<Transaction> get _thisWeeksTransactions {
    return tx_list.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  double get _thisWeekTotalSpending {
    return _thisWeeksTransactions.fold(0.0, (mysum, item) {
      return mysum + item.amount;
    });
  }

  List<Map<String, Object>> get _spending_per_day_list {
    return List.generate(
      7,
      (index) {
        var weekDay = DateTime.now().subtract(Duration(days: index));
        double amountPerDay = 0;

        for (final tx in _thisWeeksTransactions) {
          if (tx.date.day == weekDay.day &&
              tx.date.month == weekDay.month &&
              tx.date.year == weekDay.year) {
            amountPerDay += tx.amount;
          }
        }

        return {
          "day": DateFormat.E().format(weekDay),
          "amount": amountPerDay,
        };
      },
    ).reversed.toList();
  }

  void _delete_transaction(String id) {
    tx_list.removeWhere((e) => e.id == id);

    setState(() {});
  }

  void _update_transaction({Transaction tx_to_update, String title="", double amount=0.0, selected_date}){

    setState(() {

      // Update the found transaction
      tx_to_update.title = title;
      tx_to_update.amount = amount;
      tx_to_update.date = selected_date;

    });

  }

  void _start_update_transaction(BuildContext ctx, Transaction tx){

      showModalBottomSheet(
        //isScrollControlled: true,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            child: UpdateTransactionForm(_update_transaction, tx),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    print(_spending_per_day_list);
    print(_thisWeekTotalSpending);

    final appBar = AppBar(
      title: Text(widget.title),
    );

    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
//      mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                child: OneWeekChartBars(
                  spending_per_day_list: _spending_per_day_list,
                  this_week_total_spending: _thisWeekTotalSpending,
                ),
              ),
              Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                child: TransactionCardsList(
                  tx_list: tx_list,
                  delete_transaction_callback: _delete_transaction,
                  update_transaction_callback: _start_update_transaction,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
