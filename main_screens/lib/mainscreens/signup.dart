import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_screens/mainscreens/HomePage.dart';
import 'package:main_screens/custom/People.dart';

class SignUp extends StatefulWidget {
  final dynamic me; // Define a property for user information
  const SignUp({Key? key, this.me}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // TextEditingController for each input field
  TextEditingController nameController = TextEditingController();
  TextEditingController aadharIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController dependentsController = TextEditingController();

  // Boolean variable to track if terms of service are agreed
  bool agreedToTerms = false;

  void _openTermsOfService() async {
    const url =
        'https://retail.onlinesbi.sbi/sbijava/retail/html/Terms_of_Use.html';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 25;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Open Account",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 1.0),
                          const Text(
                            "Create your Udhaar account in an easy way",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: "Name",
                            ),
                          ),
                          TextField(
                            controller: aadharIdController,
                            decoration: const InputDecoration(
                              labelText: "Aadhar ID",
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                          TextField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                              labelText: "Phone",
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: "Password",
                            ),
                          ),
                          TextField(
                            controller: ageController,
                            decoration: const InputDecoration(
                              labelText: "Age",
                            ),
                          ),
                          TextField(
                            controller: salaryController,
                            decoration: const InputDecoration(
                              labelText: "Salary",
                            ),
                          ),
                          TextField(
                            controller: dependentsController,
                            decoration: const InputDecoration(
                              labelText: "Number of Dependents",
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Checkbox(
                                value: agreedToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    agreedToTerms = value!;
                                  });
                                },
                              ),
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                  onTap: _openTermsOfService,
                                  child: const Text(
                                    "I agree with the Terms of Service",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 136, 71, 21),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: agreedToTerms
                                ? () => signInWithPhoneNumber(context)
                                : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(219, 234, 141, 1),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                "Verify Phone Number",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  void signInWithPhoneNumber(BuildContext context) async {
    String?
        enteredVerificationCode; // Variable to hold the verification code entered by the user

    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      // Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
      ConfirmationResult confirmationResult =
          await auth.signInWithPhoneNumber(phoneController.text);

      // The reCAPTCHA widget will be displayed automatically.
      // After the user completes the reCAPTCHA and the SMS code is sent, proceed to sign in.

      // Prompt the user to enter the verification code
      enteredVerificationCode = await showDialog(
        context: context,
        builder: (context) {
          String verificationCode =
              ''; // Initialize an empty string to hold the verification code
          return AlertDialog(
            title: Text(
              'Enter Verification Code',
              style: TextStyle(fontSize: 18.0), // Adjust font size as needed
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      verificationCode = value; // Update the verification code as the user types
                    },
                    decoration: InputDecoration(
                      labelText: 'Verification Code',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0), // Add vertical spacing
                Text(
                  'Entered Verification Code: $verificationCode',
                  style: TextStyle(
                      fontSize: 14.0, color: Colors.grey[600]), // Gray color
                ),
              ],
            ),
            actions: [
              TextButton(
                // Use TextButton for Material Design
                onPressed: () => Navigator.pop(context, null), // Dismiss dialog
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]), // Gray color
                ),
              ),
              ElevatedButton(
                onPressed: () {
                Navigator.pop(context, verificationCode); // Dismiss dialog with entered code
                },
                child: Text('Verify'),
              ),
            ],
          );
        },
      );

      // If the user entered a code, proceed with confirmation
      if (enteredVerificationCode != null) {
        UserCredential userCredential =
            await confirmationResult.confirm(enteredVerificationCode);

        // User has been signed in successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'User signed in successfully: ${userCredential.user!.phoneNumber}')),
        );

        // Call your signing function here, passing the context if needed
        signUp(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification cancelled by user')),
        );
      }
    } catch (e) {
      print('Error signing in with phone number: $e');
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with phone number: $e'),
        ),
      );
    }
  }

  void signUp(BuildContext context) async {
    try {
      // Access Firebase Firestore
      final firestoreInstance = FirebaseFirestore.instance;

      // Check if the phone number already exists in the database
      final QuerySnapshot<Map<String, dynamic>> existingUsers =
          await firestoreInstance
              .collection('users')
              .where('phone', isEqualTo: phoneController.text)
              .get();

      // If there are existing users with the same phone number, display an alert
      if (existingUsers.docs.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert'),
              content:
                  const Text('User with this phone number already exists!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // If the phone number is unique, proceed with signing up the user

        // Store user details in a Firestore collection
        await firestoreInstance.collection('users').add({
          'name': nameController.text,
          'aadharId': aadharIdController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'age': ageController.text,
          'salary': salaryController.text,
          'dependents': dependentsController.text
          // You can add more user details here as needed
        });
        
        double normalized_salary = (double.parse(salaryController.text) - 20000) / (100000 - 20000);
        double normalized_age = (double.parse(ageController.text) - 18) / (80 - 18)  ;
        double normalized_dependents = double.parse(dependentsController.text) / 5 ;
        credit=(0.3 * normalized_salary) + (0.2 * normalized_age) + 
                    (0.1* normalized_dependents);
        credit=(credit*9)-3;
        credit = double.parse(credit.toStringAsFixed(1));

        print("User signed up successfully!");
        me = Person(
          id: me.id,
          name: nameController.text,
          imageURL: me.imageURL,
          phoneNumber: phoneController.text,
          email: emailController.text,
          idType: me.idType,
          cardNum: aadharIdController.text,
          salary: salaryController.text,
          age: ageController.text,
          dependents: dependentsController.text,
          creditScore: credit,
        );
        // Navigate back to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(me: me)),
        );
      }
    } catch (e) {
      print("Error signing up: $e");
    }
  }
}
