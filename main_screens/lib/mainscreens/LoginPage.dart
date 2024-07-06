import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
// import 'package:main_screens/custom/People.dart';
import 'package:main_screens/mainscreens/HomePage.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'ResetPassword.dart';
import 'signup.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for phone and password fields
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Function to handle login button press
  void handleLogin() async {
    try {
      // Retrieve phone and password entered by the user
      String phone = phoneController.text;
      String password = passwordController.text;

      // Query Firestore for user data based on phone number
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phone)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User with the given phone number exists
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        // Compare password
        if (userData['password'] == password) {
          // Password matches, navigate to Home screen
          try {
            final firestoreInstance = FirebaseFirestore.instance;
            try {
              final QuerySnapshot<Map<String, dynamic>> existUsers =
                  await firestoreInstance
                      .collection('users')
                      .where('phone', isEqualTo: userData['phone'])
                      .get();
              if (existUsers.docs.isNotEmpty) {
                // Extract data from the first document
                final userData = existUsers.docs.first.data();
                print("done");
                // Create a new Person object with the updated data
                // Assuming `me` is a global variable accessible here
                double normalized_salary = (double.parse(userData['salary']) - 20000) / (100000 - 20000);
                double normalized_age = (double.parse(userData['age']) - 18) / (80 - 18)  ;
                double normalized_dependents = double.parse(userData['dependents']) / 5 ;
                double normalized_ongoing_transactions = ongTransactionCount / 100 ; 
                double normalized_completed_transactions = comTransactionCount/ 500;
                
                credit=(0.3 * normalized_salary) + (0.2 * normalized_age) + 
                   (0.1* normalized_dependents) + 
                   (0.2* normalized_ongoing_transactions) + 
                   (0.2 * normalized_completed_transactions);
                credit=(credit*9)-3;
                credit = double.parse(credit.toStringAsFixed(1));
                me = Person(
                  id: userData['id'],
                  name: userData['name'],
                  phoneNumber: userData['phone'],
                  email: userData['email'],
                  idType: me.idType,
                  cardNum: userData['aadharId'],
                  salary: userData['salary'],
                  age: userData['age'],
                  dependents: userData['dependents'],
                  creditScore: credit,
                );

                // Add your logic here...
              } else {
                print("NOt done");
              }
              // Rest of your code here...
            } catch (e) {
              print('Error accessing Firestore: $e');
            }
            // If there are existing users with the same phone number, perform your desired action
          } catch (e) {
            print("Error signing up: $e");
          }
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(me: me)),
        );
        } else {
          // Incorrect password
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Incorrect password. Please try again."),
            ),
          );
        }
      } else {
        // User with the given phone number does not exist
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("User with the provided phone number does not exist."),
          ),
        );
      }
    } catch (e) {
      // Handle errors
      print('Error occurred while handling login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred. Please try again later."),
        ),
      );
    }
  }

  void callSignUp() {
    try {
      // Navigate to the SignUp screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUp()),
      );
    } catch (e) {
      print('Error occurred while handling SignUp page: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Promise"),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 3 * padding),
                child: Text(
                  "PROMISE",
                  style:
                      TextStyle(fontSize: 2 * titleFontSize, color: colorBlack),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Icon(Icons.phone),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Icon(Icons.lock),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: handleLogin,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: colorGreen,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    "Sign in",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                      color: colorBlack,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: callSignUp,
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
