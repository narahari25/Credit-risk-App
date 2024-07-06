// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
import 'package:main_screens/custom/PeopleGrid.dart';
import 'package:main_screens/custom/SearchBar.dart';
import 'package:main_screens/mainscreens/MyProfile.dart';
import 'package:main_screens/mainscreens/TransactionsListPage.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';
import 'package:provider/provider.dart';
import 'package:main_screens/custom/ListenerPage.dart';
import 'package:firebase_database/firebase_database.dart';

//remove People.dart and query firebase db for all the related lists

//if accepted = true and completed = false, add to ongtransactions
//if accepted = false and completed = true, add to comtransactions



class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.me});

  final Person me;

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ongshowAllGridElements = false;
  bool comshowAllGridElements = false;

  @override
  Widget build(BuildContext context) {
    // Assuming you get the lender's UID from authentication

    final Size size = MediaQuery.of(context).size;
    const double searchHeight = 40;

    // Determine the number of visible elements
    final int ongvisibleElementsCount = ongshowAllGridElements
        ? ongtransactions.length
        : ongtransactions.length > 8
            ? 8
            : ongtransactions.length;

    // Extract the remaining elements if any
    final List<Person> ongremainingElements = ongtransactions.sublist(
      ongvisibleElementsCount,
      ongtransactions.length,
    );

    // Determine the number of visible elements
    final int comvisibleElementsCount = comshowAllGridElements
        ? comtransactions.length
        : comtransactions.length > 8
            ? 8
            : comtransactions.length;

    // Extract the remaining elements if any
    final List<Person> comremainingElements = comtransactions.sublist(
      comvisibleElementsCount,
      comtransactions.length,
    );

    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomScrollView(slivers: [
          SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: colorBackground,
              floating: true,
              pinned: true,
              snap: true,
              toolbarHeight: 2 * padding + searchHeight,
              actions: <Widget>[
                // addHorizontalSpace(padding),
                Container(
                    child: Column(children: [
                  addVerticalSpace(padding / 2),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding / 2),
                      child: Row(children: [
                        MySearchBar(size: size, searchHeight: searchHeight),
                        addHorizontalSpace(padding / 2),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the search page or execute any other action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyProfile(me: widget.me)),
                            );
                          },
                          child: SizedBox(
                              width: searchHeight,
                              height: searchHeight,
                              child: ClipOval(
                                child: Image.asset('${widget.me.imageURL}'),
                              )),
                        )
                      ])),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Divider(
                      height: padding / 2,
                      color: colorBlack,
                    ),
                  ),
                ])),
                addVerticalSpace(padding),
              ]),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Assuming you get the lender's UID from authentication
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ListenerPage(lenderUid: widget.me.id),
                          ),
                        );
                      },
                      child: const Text('Pending Requests'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ongoing Transactions',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          addVerticalSpace(padding / 2),
                          PeopleGrid(
                            visibleElementsCount: ongvisibleElementsCount,
                            transactions: ongtransactions,
                            caCount: 4,
                          ),
                          if (ongtransactions.length > 8)
                            Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    ongshowAllGridElements =
                                        !ongshowAllGridElements;
                                  });
                                },
                                child: Text(
                                  ongshowAllGridElements
                                      ? 'Collapse'
                                      : 'View More',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: colorBlack),
                                ),
                              ),
                            ),
                          if (ongshowAllGridElements &&
                              ongremainingElements.isNotEmpty)
                            PeopleGrid(
                              visibleElementsCount: ongremainingElements.length,
                              transactions: ongremainingElements,
                              caCount: 4,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Completed Transactions',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          addVerticalSpace(padding / 2),
                          PeopleGrid(
                            visibleElementsCount: comvisibleElementsCount,
                            transactions: comtransactions,
                            caCount: 4,
                          ),
                          if (comtransactions.length > 8)
                            Container(
                              height: 100,
                              alignment: Alignment.bottomCenter,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    comshowAllGridElements =
                                        !comshowAllGridElements;
                                  });
                                },
                                child: Text(
                                  comshowAllGridElements
                                      ? 'Collapse'
                                      : 'View More',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: colorBlack),
                                ),
                              ),
                            ),
                          if (comshowAllGridElements &&
                              comremainingElements.isNotEmpty)
                            PeopleGrid(
                              visibleElementsCount: comremainingElements.length,
                              transactions: comremainingElements,
                              caCount: 4,
                            ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: padding),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransactionsListPage()),
                            );
                          },
                          child: Text(
                            'Recent Transactions',
                            style: TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                                color: colorBlack),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          )
        ]),
      ),
    ));
  }
}
