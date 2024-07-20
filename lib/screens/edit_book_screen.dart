import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';

class EditBookScreen extends StatefulWidget {
  static const routeName = '/edit-book';

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _form = GlobalKey<FormState>();
  var _editedBook = Book(id: '', title: '', author: '');
  var _isInit = true;
  var _initValues = {
    'title': '',
    'author': '',
    'rating': '0',
    'isRead': 'false',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final bookId = ModalRoute.of(context)!.settings.arguments as String?;
      if (bookId != null) {
        _editedBook = Provider.of<BookProvider>(context, listen: false).findById(bookId);
        _initValues = {
          'title': _editedBook.title,
          'author': _editedBook.author,
          'rating': _editedBook.rating.toString(),
          'isRead': _editedBook.isRead.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editedBook.id.isEmpty) {
      await Provider.of<BookProvider>(context, listen: false).addBook(_editedBook);
    } else {
      await Provider.of<BookProvider>(context, listen: false).updateBook(_editedBook.id, _editedBook);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedBook = Book(
                    id: _editedBook.id,
                    title: value!,
                    author: _editedBook.author,
                    rating: _editedBook.rating,
                    isRead: _editedBook.isRead,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['author'],
                decoration: InputDecoration(labelText: 'Author'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedBook = Book(
                    id: _editedBook.id,
                    title: _editedBook.title,
                    author: value!,
                    rating: _editedBook.rating,
                    isRead: _editedBook.isRead,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['rating'],
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 5) {
                    return 'Please enter a valid rating between 0 and 5.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedBook = Book(
                    id: _editedBook.id,
                    title: _editedBook.title,
                    author: _editedBook.author,
                    rating: int.parse(value!),
                    isRead: _editedBook.isRead,
                  );
                },
              ),
              SwitchListTile(
                title: Text('Read'),
                value: _editedBook.isRead,
                onChanged: (value) {
                  setState(() {
                    _editedBook.isRead = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
