// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
import 'package:main_screens/custom/SettingOption.dart';
import 'package:main_screens/custom/BigGreenButton.dart';
import 'package:main_screens/mainscreens/MyProfile.dart';
import 'package:main_screens/mainscreens/TransactionsWithPersonListPage.dart';
import 'package:main_screens/utils/constants.dart';
import 'package:main_screens/utils/widget_functions.dart';
import 'package:main_screens/mainscreens/RequestCreditPage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SecondProfile extends StatelessWidget {
  const SecondProfile({super.key, required this.person});

  final Person person;

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
              backgroundColor: colorBackground,
              floating: true,
              pinned: true,
              snap: true,
              actions: <Widget>[
                addHorizontalSpace(padding),
                
                Transform(
                  transform:  Matrix4.translationValues(-size.width/20, 0.0, 0.0),
                  child: Icon(Icons.add_card, color: colorBlack),
                ), 
                addVerticalSpace(padding),
              ]
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 1, 
                (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      children: [
                        addVerticalSpace(padding),
                        Column(
                          children: [
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 100,
                              height: 100,
                              
                              // child: ClipOval(child: Image.asset('${person.id}.jpg'))
                              child: ClipOval(child: Image.asset('images/${person.id}.jpg'))
                            ),
                            addVerticalSpace(padding/2),
                            Text(person.name, style: TextStyle(fontSize: 20.0),),
                            // addVerticalSpace(padding/4),
                            Text(person.phoneNumber, style: TextStyle(fontSize: 14.0, color: colorBlack.withOpacity(0.5)),)
                          ],
                        ),
                        addVerticalSpace(padding),
                        SfRadialGauge(
                          axes: <RadialAxis>[RadialAxis(minimum: -3, maximum: 6,
                            ranges: <GaugeRange>[
                              GaugeRange(startValue: -3, endValue: 0, color: Colors.red,startWidth: 20, endWidth: 20,),
                              GaugeRange(startValue: 0, endValue: 3, color: Colors.orange,startWidth: 20, endWidth: 20,),
                              GaugeRange(startValue: 3, endValue: 6, color: Colors.green, startWidth: 20, endWidth: 20,),
                            ],
                            pointers: <GaugePointer>[NeedlePointer(value: person.creditScore,)],
                            annotations: <GaugeAnnotation>[GaugeAnnotation(widget: Text(person.creditScore.toString(), style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),), angle: 90,positionFactor: 0.5)],
                          )],
                        ),
                        addVerticalSpace(padding),
                        Column(
                          children: [
                            Text("TRANSACTIONS", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w900, color: colorBlack.withOpacity(0.8)),),
                            addVerticalSpace(padding/3),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      // addVerticalSpace(padding/3),
                                      Text(
                                        "45", 
                                        style: TextStyle(height: 1.2, fontSize: 50.0, fontWeight: FontWeight.w900, color: colorBlack),
                                      ),
                                      Text("Total", style: TextStyle(height: 1.2, fontSize: 16.0, fontWeight: FontWeight.w900, color: colorBlack.withOpacity(0.7)),),
                                    ],
                                  ),
                                  addHorizontalSpace(padding/2),
                                  VerticalDivider(
                                    color: colorBlack.withOpacity(0.5),
                                    thickness: 1,
                                  ),
                                  addHorizontalSpace(padding/2),
                                  Column(
                                    children: [
                                      // addVerticalSpace(padding/3),
                                      Text(
                                        "43", 
                                        style: TextStyle(height: 1.2, fontSize: 50.0, fontWeight: FontWeight.w900, color: colorBlack),
                                      ),
                                      Text("Completed", style: TextStyle(height: 1.2, fontSize: 16.0, fontWeight: FontWeight.w900, color: colorBlack.withOpacity(0.7)),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            addVerticalSpace(padding),
                            BigGreenButton(padding: padding, text: "Request Credit", icon: Icon(Icons.add_card, color: colorBlack), widget: RequestCreditPage(borrowerUid: me.id, lenderUid: person.id,),),
                            addVerticalSpace(padding),
                            BigGreenButton(padding: padding, text: "View transactions", icon: Icon(Icons.add_card, color: colorBlack), widget: TransactionsWithPersonListPage(user: person),),
                            addVerticalSpace(padding),
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Details", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),),
                              ),
                            ),
                            addVerticalSpace(padding),
                            SettingOption(padding: padding, circularButton: false, value: person.phoneNumber, type: "Mobile number", icon: Icon(Icons.call_outlined, size: 25,),),
                            addVerticalSpace(padding),
                            SettingOption(padding: padding, circularButton: false, value: person.email, type: "E-mail id", icon: Icon(Icons.mail_outline, size: 25,),),
                            addVerticalSpace(padding),
                            SettingOption(padding: padding, circularButton: false, value: person.idType, type: "Aadhar/pan card", icon: Icon(Icons.badge_outlined, size: 25,),),
                            addVerticalSpace(padding),
                            SettingOption(padding: padding, circularButton: false, value: person.cardNum, type: "Card number", icon: Icon(Icons.money_outlined, size: 25,),),
                            addVerticalSpace(padding)
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ]
        ),
      ),
    );
  }
}

