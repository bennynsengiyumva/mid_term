import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/book_provider.dart';

class AddBookScreen extends StatefulWidget {
  static const routeName = '/add-book';

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  String _description = ''; // Added description field
  bool _isRead = false;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newBook = Book(
        id: DateTime.now().toString(),
        title: _title,
        author: _author,
        description: _description,
        // Added description parameter
        rating: 0,
        isRead: _isRead,
      );
      Provider.of<BookProvider>(context, listen: false).addBook(newBook);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Author'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide an author.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                // Added description field
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a description.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SwitchListTile(
                title: Text('Read'),
                value: _isRead,
                onChanged: (value) {
                  setState(() {
                    _isRead = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save Book'),
                onPressed: _saveForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}