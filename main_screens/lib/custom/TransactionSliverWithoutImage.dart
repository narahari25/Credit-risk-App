// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:main_screens/custom/Transaction.dart';
import 'package:main_screens/mainscreens/TransactionPage.dart';
import 'package:main_screens/utils/constants.dart';

// ignore: must_be_immutable
class TransactionSliverWithoutImage extends StatelessWidget {

  const TransactionSliverWithoutImage({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return colorBackground; // Use the component's default.
          },
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TransactionPage(transaction: transaction),)
        );
      },
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            // addHorizontalSpace(padding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.tName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text('Total Amount: ${transaction.tAmount}', style: TextStyle(fontSize: 16),),
              ],
            ),
          ],
        ),
      ),
    );

  }
}