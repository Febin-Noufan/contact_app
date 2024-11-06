import 'package:contact_app/controller/db.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For photo picking
import 'dart:io'; // For using File to store the image

class ContactFormScreen extends StatefulWidget {
  final Contact? contact;

  ContactFormScreen({this.contact});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  bool isFavorite = false;
  File? _imageFile; // To hold the picked image

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    isFavorite = widget.contact?.isFavorite ?? false;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

 void _saveContact() {
  if (_formKey.currentState!.validate()) {
    final contact = Contact(
      id: widget.contact?.id,
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      isFavorite: isFavorite,
      image: _imageFile == null ? "" : _imageFile!.path,  // Store image path as string
    );

    if (widget.contact == null) {
      DBHelper().insertContact(contact);
    } else {
      DBHelper().updateContact(contact);
    }

    Navigator.pop(context, true);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 18, 5, 5),
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
        backgroundColor: Colors.grey[850], // Dark background color for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 40,),
            GestureDetector(
  onTap: _pickImage, // Tap to pick image
  child: CircleAvatar(
    radius: 60,
    backgroundColor: Colors.grey[800],
    backgroundImage: _imageFile != null
        ? null // No background image here, we'll use Image widget instead
        : null,
    child: _imageFile == null
        ? Icon(Icons.add_a_photo, color: Colors.blueAccent)
        : ClipOval(
            child: Image.file(
              _imageFile!,
              width: 120,  // Set the size of the image (twice the radius)
              height: 120,
              fit: BoxFit.cover,  // Use BoxFit to scale the image
            ),
          ),
  ),
)
,
              const SizedBox(height: 40),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white), // White label text
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[600]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800], // Dark background for text field
                ),
                style: TextStyle(color: Colors.white), // White text inside text field
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.white), // White label text
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[600]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800], // Dark background for text field
                ),
                style: TextStyle(color: Colors.white), // White text inside text field
                validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white), // White label text
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[600]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800], // Dark background for text field
                ),
                style: TextStyle(color: Colors.white), // White text inside text field
                validator: (value) => value!.isEmpty ? 'Enter email' : null,
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Favorite',
                  style: TextStyle(color: Colors.white), // White text color
                ),
                value: isFavorite,
                activeColor: Colors.blueAccent, // Accent color for checkbox
                checkColor: Colors.white, // Color of the checkmark
                onChanged: (bool? value) {
                  setState(() {
                    isFavorite = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveContact,
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  widget.contact == null ? 'Save' : 'Update Contact',
                  style: TextStyle(color: Colors.white), // White text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
