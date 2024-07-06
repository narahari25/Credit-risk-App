import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
import 'package:main_screens/custom/PeopleGrid.dart';
import 'package:main_screens/custom/SearchBar.dart';
import 'package:main_screens/mainscreens/AcceptRejectPage.dart';
import 'package:main_screens/mainscreens/HomePage.dart';
import 'package:main_screens/mainscreens/MyProfile.dart';
import 'package:main_screens/mainscreens/TransactionsListPage.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';
import 'package:main_screens/mainscreens/RequestCreditPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:main_screens/custom/Transaction.dart' as MyTransaction;
import 'package:main_screens/custom/NewPage.dart';

Stream<DatabaseEvent> listenForNotifications(int lenderUid) {
  final databaseReference = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: "https://promise-2494a-default-rtdb.firebaseio.com")
      .ref()
      .child('user_notifications/$lenderUid');
  return databaseReference.onValue;
}

class ListenerPage extends StatelessWidget {
  final int lenderUid;

  const ListenerPage({super.key, required this.lenderUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: listenForNotifications(lenderUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
  
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          // if (!snapshot.hasData) {
            return const Text('No notifications yet');
          }
          print(snapshot.data!.snapshot.value);
          final stringData = '${snapshot.data!.snapshot.value}';
          final newStringData = stringData.substring(1, stringData.length - 1);
          List<String> numbers = newStringData.split(', '); 
          List<String> slicedNumbers = [];
          // Loop through each string in the original list
          for (String str in numbers) {
            // Slice the string, excluding the last 4 characters
            String slicedString = (str.substring(0, str.length - 7));

            // Add the sliced string to the new list
            slicedNumbers.add(slicedString);
          }
          print(slicedNumbers.runtimeType); // Notification data
          final notifications = slicedNumbers; // Convert to list

          if (notifications.isEmpty) {
            return const Text('No notifications yet');
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              if (notifications[index] == 0) {
                return const Text('No notifications yet');
              }
              final transactionDetails =
                  notifications[index].split(','); // Get unique key
              //build transaction class and pass it to the transaction page

              //get bor by querying db for user with borrowerID, get len

              // final MyTransaction.Transaction tran = MyTransaction.Transaction(
              //   accepted: transaction['accepted'],
              //   tAmount: transaction['amount'],
              //   borrower: people[0],
              //   completed: transaction['completed'],
              //   dueDate: transaction['date_due'],
              //   tId: transaction['id'],
              //   tDate: transaction['date'],
              //   lender: people[1],
              //   interest: transaction['interest'],
              //   tName: transaction['name'],
              // );

              // // Extract and display relevant information from transaction
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
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5);
                      }
                      return colorBackground; // Use the component's default.
                    },
                  ),
                ),
                onPressed: () {
                  print("pushing context arpage");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          // AcceptRejectPage(transactionId: transactionDetails[0]),
                          NewPage(transactionId: transactionDetails[0]),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: padding),// Adjust the space between image and text
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactionDetails[1],
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorBlack),
                          ),
                          Text(
                            '${transactionDetails[1]} | Total Amount: ${transactionDetails[2]}',
                            style: TextStyle(fontSize: 16, color: colorBlack),
                          ),
                        ],
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



// class TransactionListener {
//   final int lenderUid;
//   final Function(MyTransaction.Transaction transaction) onTransactionReceived;

//   TransactionListener({required this.lenderUid, required this.onTransactionReceived});

//   DatabaseReference? _notificationRef;

//   void startListening() {
//     _notificationRef = FirebaseDatabase.instance.ref().child('user_notifications/$lenderUid');

//     _notificationRef!.onChildAdded.listen((event) {
//       final notificationData = event.snapshot.value as Map;
//       final transactionId = notificationData['request']['id'] as String;

//       // Fetch transaction details
//       getTransactionDetails(transactionId);
//     });
//   }

//   void getTransactionDetails(String transactionId) async {
//     final transactionRef = FirebaseDatabase.instance.ref().child('transactions/$transactionId');

//     final transactionSnapshot = await transactionRef.once();
//     if (transactionSnapshot.snapshot.exists) {
//       final data = transactionSnapshot.snapshot.value as Map;
//       final transaction = MyTransaction.Transaction(
//         tName: data['name'] as String,
//         tId: data['id'] as String,
//         borrower: Person(
//           id: data['borrower']['id'] as int,
//           name: data['borrower']['name'] as String,
//           imageURL: data['borrower']['imageURL'] as String,
//           phoneNumber: data['borrower']['phoneNumber'] as String,
//           email: data['borrower']['email'] as String,
//           idType: data['borrower']['idType'] as int,
//           cardNum: data['borrower']['cardNum'] as String,
//           creditScore: data['borrower']['creditScore'] as double,
//           salary: data['borrower']['salary'] as String,
//           age: data['borrower']['age'] as String,
//           dependents: data['borrower']['dependents'] as String,
//         ),
//         lender: Person(
//           id: data['lender']['id'] as int,
//           name: data['lender']['name'] as String,
//           imageURL: data['lender']['imageURL'] as String,
//           phoneNumber: data['lender']['phoneNumber'] as String,
//           email: data['lender']['email'] as String,
//           idType: data['lender']['idType'] as int,
//           cardNum: data['lender']['cardNum'] as String,
//           creditScore: data['lender']['creditScore'] as double,
//           salary: data['lender']['salary'] as String,
//           age: data['lender']['age'] as String,
//           dependents: data['lender']['dependents'] as String,
//         ),
//         tAmount: data['amount'] as double,
//         interest: data['interest'] as double,
//         tDate: data['date'] as int,
//         dueDate: data['date_due'] as int,
//         accepted: data['accepted'] as bool,
//         completed: data['completed'] as bool,
//       );

//       onTransactionReceived(transaction); // Call callback with transaction data
//     }
//   }

//   // void stopListening() {
//   //   _notificationRef?.dispose();
//   // }
// }