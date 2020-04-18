import 'package:flutter/material.dart';
import './TransactionCard.dart';
import '../models/Transaction.dart';

class TransactionCardsList extends StatelessWidget {
  List<Transaction> tx_list;
  Function delete_transaction_callback;
  Function update_transaction_callback;

  TransactionCardsList({
    @required this.tx_list,
    @required this.delete_transaction_callback,
    @required this.update_transaction_callback,
  });

  @override
  Widget build(BuildContext context) {

    return tx_list.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.07,
                    child: Text(
                      "No transactions added yet!",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: constraints.maxHeight * 0.88,
                    child: Image.asset(
                      'assets/images/dog.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: tx_list.length,
            itemBuilder: (context, index) {
              return TransactionCard(
                tx: tx_list[index],
                delete_transaction_callback: delete_transaction_callback,
                update_transaction_callback: update_transaction_callback,
              );
            },
          );
  }
}
