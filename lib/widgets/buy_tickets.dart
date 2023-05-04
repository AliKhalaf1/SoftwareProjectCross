library BuyTicketsWidget;

import 'package:flutter/material.dart';

class BuyTickets extends StatefulWidget {
  final eventId;
  const BuyTickets(this.eventId, {super.key});

  @override
  State<BuyTickets> createState() => _BuyTicketsState();
}

class _BuyTicketsState extends State<BuyTickets> {
  final titleInp = TextEditingController();

  final amountInp = TextEditingController();

  void purchase() {}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value) {
              //   titleInp = value;
              // },
              controller: titleInp,
              onSubmitted: (_) => purchase(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged:(value) {
              //   amountInp = value;
              // },
              controller: amountInp,
              onSubmitted: (_) => purchase(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextButton(
              onPressed: purchase,
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColorDark),
            )
          ],
        ),
      ),
    );
    ;
  }
}
