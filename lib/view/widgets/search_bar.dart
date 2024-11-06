import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
  padding: const EdgeInsets.all(16.0),
  child: TextField(
   // controller: searchController,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.search, color: Colors.white),
      hintText: 'Search Contacts',
      hintStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: const Color.fromARGB(255, 49, 25, 25),
      contentPadding: const EdgeInsets.symmetric(vertical: 15), // Adjust the padding
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      suffixIcon: const Padding(
        padding: EdgeInsets.all(5.0), // Add padding to adjust the position
        child: CircleAvatar(
          radius: 13, // Adjust the radius here for smaller size
          backgroundColor: Colors.blueAccent,
          child: Text(
            'F', // Text for the CircleAvatar
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    ),
    textAlignVertical: TextAlignVertical.center,
  ),
)
;
  }
}