import 'package:flutter/material.dart';

import '../screens/search.dart';

class SearchBar extends StatelessWidget {
  SearchBar({super.key});
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Color.fromARGB(31, 223, 220, 220),
          border: Border.all(color: Color.fromARGB(95, 86, 85, 85)),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              cursorColor: Colors.black.withOpacity(0.5),
              decoration: const InputDecoration(
                hintText: "Search Wallpapers",
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Search(query: _searchController.text)));
            },
            child: Icon(
              Icons.search,
              size: 35,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
