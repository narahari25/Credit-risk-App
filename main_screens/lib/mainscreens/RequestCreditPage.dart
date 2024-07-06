import 'dart:html';
import 'dart:math';

import 'package:main_screens/custom/People.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date formatting
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

String generateUniqueId() {
  final now = DateTime.now();
  final timestamp = now.millisecondsSinceEpoch.toString();
  final random = Random().nextInt(10000).toString().padLeft(4, '0');
  return '$timestamp$random';
}

class RequestCreditPage extends StatefulWidget {
  final int borrowerUid;
  final int lenderUid;

  const RequestCreditPage(
      {super.key, required this.borrowerUid, required this.lenderUid});

  @override
  State<RequestCreditPage> createState() => _RequestCreditPageState();
}

class _RequestCreditPageState extends State<RequestCreditPage> {
  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  final _interestController = TextEditingController();

  DateTime _dueDate = DateTime.now();

  var flag = 0;
  // Adding a transaction
  Future<void> _submitRequest() async {
    try {
      if (_formKey.currentState!.validate()) {
        final amount = double.parse(_amountController.text);
        final interest = double.parse(_interestController.text);
        final name = _nameController.text;
        final dueDate = _dueDate?.millisecondsSinceEpoch;

        final uniqueId = generateUniqueId();
        print(uniqueId);
        // Create transaction data
        final transaction = {
          'name': name,
          'id': uniqueId,
          'date': Timestamp.now(),
          'date_due': dueDate,
          'borrowerID': widget.borrowerUid,
          // 'lenderID': widget.lenderUid,
          'lenderID': me.id,
          'interest': interest,
          'amount': amount,
          'accepted': false,
          'completed': false,
        };

        // Add transaction to Firestore Realtime Database
        final transactionRef = FirebaseDatabase.instanceFor(
                app: Firebase.app(),
                databaseURL:
                    "https://promise-2494a-default-rtdb.firebaseio.com")
            .ref()
            .child('transactions')
            .child('${uniqueId}');
        // final transactionRef =
        //     FirebaseDatabase.instance.ref().child('transactions').push();
        await transactionRef.set(transaction);

        // Add notification directly to user_notifications collection
        final lenderNotificationsRef = FirebaseDatabase.instanceFor(
                app: Firebase.app(),
                databaseURL:
                    "https://promise-2494a-default-rtdb.firebaseio.com")
            .ref()
            .child('user_notifications/${me.id}');

        await lenderNotificationsRef.update({'${uniqueId},${name},${amount}': 'boo'});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credit request sent successfully!'),
          ),
        );
        Navigator.pop(
            context); // Assuming you want to pop back after submitting
      }
    } catch (error) {
      print("Error submitting request: $error");
    }
  }

  // Listener for user notifications (Optional, for in-app updates)
  Stream<DatabaseEvent> listenForNotifications() {
    final userNotificationsRef = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL: "https://promise-2494a-default-rtdb.firebaseio.com")
        .ref()
        .child('user_notifications/${me.id}');
    return userNotificationsRef.onChildAdded;
  }

  // Widget using the listener (Optional)
  Widget buildNotificationList(Stream<DatabaseEvent> notificationStream) {
    return StreamBuilder<DatabaseEvent>(
      stream: notificationStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Text('No notifications yet');
        }

        final notification = snapshot.data!.snapshot.value as Map;
        final transaction = notification['request'];

        // Display notification data (e.g., name, amount)
        return Text('New request: ${transaction['name']}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Credit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name of Request'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a name for the request'
                    : null,
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the amount'
                    : null,
              ),
              TextFormField(
                controller: _interestController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Interest Rate (%)'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the amount'
                    : null,
              ),
              TextButton(
                onPressed: () => _selectDueDate(context),
                child: Text(flag != 0
                    ? DateFormat('d/M/y').format(_dueDate!)
                    : 'Select Due Date'),
              ),
              ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('Request Credit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 4),
    );
    if (selectedDate != null) {
      setState(() {
        _dueDate = selectedDate;
      });
      flag = 1;
    }
  }
}
