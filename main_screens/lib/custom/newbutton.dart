import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';

Future<void> updateTransaction(String transactionId, bool accept) async {
  try {
    final tref = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL: "https://promise-2494a-default-rtdb.firebaseio.com")
        .ref()
        .child('transactions/{$transactionId}');

    if (accept) {
      await tref.update({'transactionStatus': 'accepted'});

      
    } else {
      await tref.update({'transactionStatus': 'rejected'});
    }

    print('Transaction status updated successfully');
  } on FirebaseException catch (e) {
    print('Error updating transaction status: $e');
    // Handle errors (e.g., display an error message)
  }
}

class NewButton extends StatelessWidget {
  const NewButton({
    super.key,
    required this.padding,
    required this.text,
    required this.icon,
    required this.transactionId,
    required this.accept,
  });

  final double padding;
  final String text;
  final Icon icon;
  final String transactionId;
  final bool accept;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.fromLTRB(padding, 30, padding, 30),
        // foregroundColor: Mat erialStateProperty.all<Color>(Colors.blue),
        backgroundColor: const Color.fromRGBO(219, 234, 141, 1),
      ),
      onPressed: () async {
        await updateTransaction(transactionId, accept);
        if(accept)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Transaction accepted successfully!')),
          );
        }
        else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Transaction rejected')),
          );
        }
        
        // Update UI based on successful update (optional)
      },
      child: Align(
        // alignment: Alignment.center,
        // color: Colors.red,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            addHorizontalSpace(padding / 3),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: colorBlack),
            ),
          ],
        ),
      ),
    );
  }
}
