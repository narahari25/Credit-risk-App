import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date formatting
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
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

  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      try {
        final amount = double.parse(_amountController.text);
        final interest = double.parse(_interestController.text);
        final name = _nameController.text;
        final dueDate = _dueDate?.millisecondsSinceEpoch;

        // Add transaction to Firestore
        final transaction = {
          'name': name,
          'date': Timestamp.now(),
          'date_due': _dueDate,
          'borrowerID': widget.borrowerUid,
          'lenderID': widget.lenderUid,
          'interest': interest,
          'amount': amount,
          'accepted': false,
          'completed': false,
        };

        await FirebaseFirestore.instance
            .collection('transactions')
            .add(transaction);

        // Show success message and potentially navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credit request sent successfully!'),
          ),
        );
        Navigator.pop(
            context); // Assuming you want to pop back after submitting
      } catch (e) {
        print("Error submitting request: $e");
      }
    }
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
