// edit_book_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/book_provider.dart';

class EditBookScreen extends StatefulWidget {
  static const routeName = '/edit-book';

  final Book? book;

  EditBookScreen({this.book});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _author;
  late String _description;

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _title = widget.book!.title;
      _author = widget.book!.author;
      _description = widget.book!.description;
    } else {
      _title = '';
      _author = '';
      _description = '';
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final bookProvider = Provider.of<BookProvider>(context, listen: false);

      if (widget.book != null) {
        bookProvider.updateBook(
          widget.book!.id,
          Book(
            id: widget.book!.id,
            title: _title,
            author: _author,
            description: _description,
            rating: widget.book!.rating,
            isRead: widget.book!.isRead,
          ),
        );
      } else {
        bookProvider.addBook(
          Book(
            id: DateTime.now().toString(),
            title: _title,
            author: _author,
            description: _description,
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book != null ? 'Edit Book' : 'Add Book'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _title = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _author = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide an author.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a description.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}