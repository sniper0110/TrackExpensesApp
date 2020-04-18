import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double todaySpending;
  final double spendingRatio;

  ChartBar(
      {@required this.day,
      @required this.todaySpending,
      @required this.spendingRatio});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          //padding: EdgeInsets.all(constraints.maxHeight * 0.02),
          child: Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.2,
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: FittedBox(
                  child: Text("\$$todaySpending"),
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10),
                        ),
                        color: Colors.grey.shade200,
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: spendingRatio,
                      child: Container(
                        width: constraints.maxWidth * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.2,
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: FittedBox(
                  child: Text(
                    day,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
