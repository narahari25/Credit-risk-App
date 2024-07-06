import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
import 'package:main_screens/mainscreens/SecondProfile.dart';
import 'package:main_screens/utils/constants.dart';


class PeopleGrid extends StatelessWidget {
  const PeopleGrid({
    super.key,
    required this.visibleElementsCount,
    required this.caCount,
    required this.transactions,
  });

  final int visibleElementsCount;
  final int caCount;
  final List<Person> transactions;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: caCount,
        mainAxisSpacing: padding/2,
        crossAxisSpacing: padding / 2,
      ),
      itemCount: visibleElementsCount,
      itemBuilder: (BuildContext context, int index) {
        return TextButton(
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.symmetric(horizontal: padding/4, vertical: padding/4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                
            backgroundColor: colorBackground,
          ),
          // onHover: ,
          onPressed: () {},

          child: Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to the search page or execute any other action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondProfile(person: transactions[index])),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, padding/2, 0, 0),
                      child: Container(
                              // width: 64,
                              // height: 64,
                              child: ClipOval(child: Image.asset(transactions[index].imageURL), )
                            ),
                      
                    ),
                  ),
                  Text(
                    transactions[index].name,
                    style: const TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold,
                      color: colorBlack),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
                      
      },
    );
  }
}

