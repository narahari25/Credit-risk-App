// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
import 'package:main_screens/custom/SettingOption.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';

class MyProfile extends StatefulWidget {
  final Person me;

  const MyProfile({super.key, required this.me});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {


  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchValue in initState
  }

  Future<void> fetchData() async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      final QuerySnapshot<Map<String, dynamic>> existingUsers =
          await firestoreInstance
              .collection('users')
              .where('phone', isEqualTo: widget.me.phoneNumber)
              .get();

      if (existingUsers.docs.isNotEmpty) {
        final userData = existingUsers.docs.first.data();
        setState(() {
          me = Person(
            id: widget.me.id,
            name: userData['name'],
            imageURL: widget.me.imageURL,
            phoneNumber: widget.me.phoneNumber,
            email: userData['email'],
            idType: widget.me.idType,
            cardNum: userData['aadharId'],
            salary: widget.me.salary,
            age: widget.me.age,
            dependents: widget.me.dependents,
            creditScore: widget.me.creditScore,
          );
        });
      }
    } catch (e) {
      print("Error fetching data: ${e}");    
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
          SliverAppBar(
              backgroundColor: colorBackground,
              floating: true,
              snap: true,
              title: Container(
                height: 50,
                width: size.width,
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                    child: Icon(Icons.edit, color: colorBlack, size: 30)),
              ),
              actions: <Widget>[
                // addHorizontalSpace(padding),
              ]),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(padding, padding, 0, 0),
                            child: Text("Profile",
                                style: TextStyle(fontSize: titleFontSize))),
                      ),

                      // addVerticalSpace(padding),

                      Column(
                        children: [
                          // ignore: sized_box_for_whitespace
                          Container(
                              width: 250,
                              height: 250,
                              child: ClipOval(
                                child: Image.asset('${me.imageURL}'),
                              )),
                          addVerticalSpace(padding / 2),
                          Text(
                            me.name,
                            style: TextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.bold),
                          ),
                          // addVerticalSpace(padding/4),
                        ],
                      ),
                      addVerticalSpace(padding),
                      SettingOption(
                        padding: padding,
                        circularButton: false,
                        value: me.phoneNumber,
                        type: "Mobile number",
                        icon: Icon(
                          Icons.call_outlined,
                          size: 25,
                        ),
                      ),
                      addVerticalSpace(padding),
                      SettingOption(
                        padding: padding,
                        circularButton: false,
                        value: me.email,
                        type: "E-mail id",
                        icon: Icon(
                          Icons.mail_outline,
                          size: 25,
                        ),
                      ),
                      addVerticalSpace(padding),
                      SettingOption(
                        padding: padding,
                        circularButton: false,
                        value: me.idType,
                        type: "Aadhar/pan card",
                        icon: Icon(
                          Icons.badge_outlined,
                          size: 25,
                        ),
                      ),
                      addVerticalSpace(padding),
                      SettingOption(
                        padding: padding,
                        circularButton: false,
                        value: me.cardNum,
                        type: "Card number",
                        icon: Icon(
                          Icons.money_outlined,
                          size: 25,
                        ),
                      ),
                      addVerticalSpace(padding)
                    ],
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
