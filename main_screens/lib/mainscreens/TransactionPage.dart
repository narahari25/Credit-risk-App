// ignore_for_file: prefer_const_constructors

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:main_screens/custom/Transaction.dart';
import 'package:main_screens/custom/SettingOption.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 25;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              // pinned: true,
              backgroundColor: colorBackground,
              expandedHeight: 150.0,
              collapsedHeight: 30 + 2*padding,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsetsDirectional.only(
                  start: 2.5*padding,
                  bottom: padding,
                  top: padding
                ),
                title: Text(transaction.tName, style: TextStyle(color: colorBlack, height: 1.2),),
              ),
              actions: const <Widget>[
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 1,
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      ClipPath(
                        clipper: StarClipper(16), // Create a StarClipper with 5 points
                        child: Container(
                          color: colorGreen,
                          width: 400,
                          height: 400,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "NEXT PAYMENT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorBlack.withOpacity(0.5)
                                  ),
                                ),
                                Text(
                                  "₹${transaction.tAmount}",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "DUE BY",
                                  style: TextStyle(
                                    color: colorBlack.withOpacity(0.5),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  "31 MAY 2024",
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                )
                              ],
                            ),
                        ),
                        ),
                        addVerticalSpace(padding),
                        SettingOption(padding: padding, circularButton: false, value: "Aisha Harris", type: "Lender", icon: Icon(Icons.mail_outline, size: 25,)),
                        addVerticalSpace(padding),
                        SettingOption(padding: padding, circularButton: false, value: "${transaction.tAmount}", type: "Total amount due", icon: Icon(Icons.payments, size: 25,)),
                        addVerticalSpace(padding),
                        SettingOption(padding: padding, circularButton: false, value: "${transaction.interest}", type: "Interest", icon: Icon(Icons.payments, size: 25,)),
                        addVerticalSpace(padding),
                        // SettingOption(padding: padding, circularButton: false, value: "5 years", type: "Transaction Period", icon: Icon(Icons.schedule, size: 25,)),
                        // addVerticalSpace(padding),
                        SettingOption(padding: padding, circularButton: true, value: "More details", type: "View other details", icon: Icon(Icons.expand_more, size: 25,))
                    ]
                  );
                }
              )
            )
          ]
        )
      )
    );
  }
}

class StarClipper extends CustomClipper<Path> {
  StarClipper(this.numberOfPoints);

  /// The number of points of the star
  final int numberOfPoints;

  late int counter = 0;

  @override
  Path getClip(Size size) {
    double width = size.width;

    double halfWidth = width / 2;

    double bigRadius = halfWidth;

    double radius = halfWidth / 1.11;

    double degreesPerStep = _degToRad(360 / numberOfPoints) as double;

    double halfDegreesPerStep = degreesPerStep / 2;

    double outerCurveRadius = width / 2.08;
    double innerCurveRadius = width / 2.42;

    var path = Path();

    double max = 2 * math.pi;

    path.moveTo(width, halfWidth);

    debugPrint('halfWidth: $halfWidth');
    debugPrint('bigRadius: $bigRadius');
    debugPrint('degreesPerStep: $degreesPerStep');
    debugPrint('max: $max');

    path.moveTo(
      halfWidth + radius * math.cos(0 + halfDegreesPerStep),
      halfWidth + radius * math.sin(0 + halfDegreesPerStep),
    );

    for (double step = 0; step < max + 1; step += degreesPerStep) {
      if (counter % 2 == 0) {
        path.quadraticBezierTo(
          halfWidth + outerCurveRadius * math.cos(step),
          halfWidth + outerCurveRadius * math.sin(step),
          halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep),
        );
      } else {
        path.quadraticBezierTo(
          halfWidth + innerCurveRadius * math.cos(step),
          halfWidth + innerCurveRadius * math.sin(step),
          halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep),
        );
      }
      counter++;
    }
    path.close();
    return path;
  }

  num _degToRad(num deg) => deg * (math.pi / 180.0);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    StarClipper oldie = oldClipper as StarClipper;
    return numberOfPoints != oldie.numberOfPoints;
  }
}
