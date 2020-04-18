import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';




class UpdateTransactionForm extends StatefulWidget {
  final Function _update_transaction_callback;
  Transaction tx_to_update;

  UpdateTransactionForm(this._update_transaction_callback, this.tx_to_update);

  @override
  _UpdateTransactionFormState createState() => _UpdateTransactionFormState();
}

class _UpdateTransactionFormState extends State<UpdateTransactionForm> {
  final _title_controller = TextEditingController();
  final _amount_controller = TextEditingController();
  var selected_date;

  @override
  void initState(){
    _title_controller.text = widget.tx_to_update.title;
    _amount_controller.text = widget.tx_to_update.amount.toString();
    selected_date = widget.tx_to_update.date;

    return super.initState();
  }

  void submitData() {
    String title_text = _title_controller.text;
    double amount_value = double.parse(_amount_controller.text);

    if (title_text.isEmpty || amount_value <= 0 || selected_date == null) {
      return;
    }

    widget._update_transaction_callback( //_update_transaction_callback
      tx_to_update: widget.tx_to_update,
      title: title_text,
      amount: amount_value,
      selected_date: selected_date,
    );

    Navigator.of(context).pop();
  }


  void pick_date() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((onValue) {
      selected_date = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _title_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: _amount_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'amount',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: selected_date == null
                      ? Text("Date not chosen yet!")
                      : Text("Chosen date : ${DateFormat.yMd().format(selected_date)}"),
                ),
              ),
              FlatButton(
                onPressed: pick_date,
                child: Text(
                  "Pick date",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          FlatButton(
            onPressed: submitData,
            child: Text(
              "save tx",
            ),
          )
        ],
      ),
      elevation: 5.0,
    );
  }
}
