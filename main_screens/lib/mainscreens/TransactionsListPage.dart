import 'package:flutter/material.dart';
import 'package:main_screens/custom/Transaction.dart';
import 'package:main_screens/custom/TransactionSliver.dart';
import 'package:main_screens/utils/constants.dart';

class TransactionsListPage extends StatelessWidget {
  const TransactionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 25;

    return Scaffold(
      appBar: AppBar(backgroundColor: colorBackground,),
      body: Column(
        
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Text("My Transactions", style: TextStyle(fontSize: titleFontSize)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return TransactionSliver(transaction: transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
