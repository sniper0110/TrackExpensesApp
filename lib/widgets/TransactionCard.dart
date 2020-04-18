import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction tx;
  final Function delete_transaction_callback;
  final Function update_transaction_callback;

  TransactionCard({
    @required this.tx,
    @required this.delete_transaction_callback,
    @required this.update_transaction_callback,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Card(
          child: Container(
            //padding: EdgeInsets.all(5),
            color: Theme.of(context).primaryColorLight,
            child: Row(
              children: <Widget>[
                Container(
                  width: constraints.maxWidth * 0.15,
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 20,
                  ),
                  child: FittedBox(
                    child: CircleAvatar(
                      //radius: 5,
                      backgroundColor:
                          Theme.of(context).primaryColor, //Colors.white,
                      child: FittedBox(
                        child: Text(
                          '\$${tx.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            //fontSize: 22,
                            color: Colors.black, //Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          tx.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          DateFormat.yMd().format(tx.date),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            delete_transaction_callback(tx.id);
                          },
                          alignment: Alignment.topRight,
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.update),
                          onPressed: () {
                            update_transaction_callback(context, tx);
                          },
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          elevation: 15,

        );
      },
    );
  }
}
