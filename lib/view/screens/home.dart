import 'dart:io';
import 'dart:math';

import 'package:contact_app/controller/db.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/view/screens/contact_form.dart';
import 'package:contact_app/view/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContacts();
    searchController.addListener(_filterContacts);
  }

  Future<void> _loadContacts() async {
    final data = await DBHelper().getContacts();
    setState(() {
      contacts = data;
      filteredContacts = data; // Initially, show all contacts
    });
  }

  void _filterContacts() {
    setState(() {
      filteredContacts = contacts
          .where((contact) => contact.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _refreshContacts() {
    _loadContacts();
  }

  void _deleteContact(int id) async {
    await DBHelper().deleteContact(id);
    _refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 5, 5),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const SearchBarWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return Card(
                  color: const Color.fromARGB(255, 18, 5, 5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      child: contact.image.isNotEmpty
                          ? ClipOval(
                              child: Image.file(
                              File(contact.image),
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ))
                          : Text(
                              contact.name.isNotEmpty
                                  ? contact.name[0].toUpperCase()
                                  : '',
                              style: const TextStyle(color: Colors.white),
                            ),
                    ),
                    title: Text(
                      contact.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContactFormScreen(contact: contact),
                        ),
                      );
                      if (result == true) _refreshContacts();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactFormScreen()),
          );
          if (result == true) _refreshContacts();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
