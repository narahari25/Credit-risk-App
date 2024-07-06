
import 'package:flutter/material.dart';
import 'package:main_screens/custom/People.dart';
import 'package:main_screens/mainscreens/SecondProfile.dart';
import 'package:main_screens/utils/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  late TextEditingController _searchController;
  List<Person> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _searchResults = people
          .where((person) =>
              person.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Scaffold(
          
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.search, color: colorBlack.withOpacity(0.7)),
                
                hintText: 'Search for people...',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: colorBlack.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
            
          body: _buildSearchResults(),
        ),

        )
    );
  }

  
  Widget _buildSearchResults() {
    if (_searchController.text.isEmpty) {
      return Center(
        child: Text(
          'Start searching...', 
          style: TextStyle(
            fontSize: 18,
            color: colorBlack.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else if (_searchResults.isEmpty) {
      return Center(
        child: Text(
          'No results found...',
          style: TextStyle(
            fontSize: 18,
            color: colorBlack.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                }
                return colorBackground; // Use the component's default.
              },
            ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondProfile(person: _searchResults[index]),
                ),
              );
            },
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: padding, vertical: padding/3),
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, padding/2, 0),
                
                child: Container(
                  // width: 64,
                  // height: 64,
                  child: ClipOval(child: Image.asset(_searchResults[index].imageURL), )
                ),
              ),
              title: Text(_searchResults[index].name, 
                style: const TextStyle(
                  fontSize: 18,
                  color: colorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(_searchResults[index].phoneNumber, 
                style: const TextStyle(
                  fontSize: 14,
                  color: colorBlack,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          );
        }
      );
      
    }
  }
}
