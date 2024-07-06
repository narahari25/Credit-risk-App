import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreditScorePage extends StatefulWidget {
  const CreditScorePage({super.key});

  

  @override
  // ignore: library_private_types_in_public_api
  _CreditScorePageState createState() => _CreditScorePageState();
}

class _CreditScorePageState extends State<CreditScorePage> {
  double creditScore = 0; // Initialize credit score

  Map<String, dynamic> userData = {
    'RevolvingUtilizationOfUnsecuredLines': 0.3745401188473625,
    'age': 70,
    'NumberOfTime30-59DaysPastDueNotWorse': 10,
    'DebtRatio': 2.719028639331187,
    'MonthlyIncome': 8850,
    'NumberOfOpenCreditLinesAndLoans': 8,
    'NumberOfTimes90DaysLate': 19,
    'NumberRealEstateLoansOrLines': 1,
    'NumberOfTime60-89DaysPastDueNotWorse': 8,
    'NumberOfDependents': 1,
    'CreditScore': 613,
  };

  Future<void> fetchCreditScore(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/predict_credit_score'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response
        Map<String, dynamic> data = jsonDecode(response.body);
          setState(() {
            creditScore = data['credit_score'];
        });
      } 
      else {
        creditScore = 25; 
      }
    } 
    catch (error) {
      print(error.toString());
      setState(() {
        creditScore = 25; // Set credit score to 0 in case of error
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Score Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                
                fetchCreditScore(userData);
              },
              child: Text('Calculate Credit Score'),
            ),
            SizedBox(height: 20),
            Text(
              'Credit Score: ${creditScore.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Credit Score App',
    home: CreditScorePage(),
  ));
}