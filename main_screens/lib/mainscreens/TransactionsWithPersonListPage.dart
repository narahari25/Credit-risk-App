import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
import 'package:main_screens/custom/Transaction.dart';
import 'package:main_screens/custom/TransactionSliverWithoutImage.dart';
import 'package:main_screens/utils/constants.dart';

class TransactionsWithPersonListPage extends StatelessWidget {
  const TransactionsWithPersonListPage({super.key, required this.user});

  final Person user;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 25;

    return Scaffold(
      appBar: AppBar(backgroundColor: colorBackground,),
      body: Column(
        
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: Text("My Transactions with ${user.name}", style: const TextStyle(fontSize: titleFontSize)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return TransactionSliverWithoutImage(transaction: transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
