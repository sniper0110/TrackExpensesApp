import 'package:flutter/material.dart';
import './ChartBar.dart';



class OneWeekChartBars extends StatelessWidget {

  final spending_per_day_list;
  final double this_week_total_spending;

  OneWeekChartBars({@required this.spending_per_day_list, @required this.this_week_total_spending});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ...spending_per_day_list.map((item) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                day: item["day"].toString(),
                todaySpending: (item["amount"] as double),
                spendingRatio: this_week_total_spending == 0
                    ? 0.0
                    : ((item["amount"] as double) / this_week_total_spending),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
