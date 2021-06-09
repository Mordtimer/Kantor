import 'package:flutter/material.dart';


class RatesHistory extends StatefulWidget {
  @override
  State<RatesHistory> createState() => _RatesHistoryState();
}

class _RatesHistoryState extends State<RatesHistory> {
  Color pickColor(int index) {
    if (index % 2 == 0)
      return Colors.white;
    else
      return Theme.of(context).cardColor;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Container(
                    // ---------------------------------------------------------------------------------------- TODO: Graph
                    color: Colors.white),
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Exchange Rate History Details",
                          style: Theme.of(context).textTheme.headline5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date",
                            style: Theme.of(context).textTheme.bodyText1),
                        //Icon(icon) // Rate Indicator - UpArrowGreen/DownArrowRed
                        Text("Exchange Rate",
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                          // ---------------------------------------------------------------------------------------- Rates History Details List -
                          itemCount: 50,
                          //separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            return Container(
                              color: pickColor(index),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("01.01.2021"),
                                  //Icon(icon) // Rate Indicator - UpArrowGreen/DownArrowRed
                                  Text("1.00")
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
