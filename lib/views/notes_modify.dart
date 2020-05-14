import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testtodolist/models/notes.dart';
import 'package:testtodolist/services/notes_services.dart';

class NotesModify extends StatefulWidget {
  final String id;

  const NotesModify({Key key, this.id}) : super(key: key);

  @override
  _NotesModifyState createState() => _NotesModifyState();
}

class _NotesModifyState extends State<NotesModify> {
  bool get isEditing => widget.id != null;

  NotesServices get services => GetIt.I<NotesServices>();

  String errorMessage;
  Notes notes;

  bool _isLoading = false;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });

    services.getNotes(widget.id).then((response){
      setState(() {
        _isLoading = false;
      });

      if (response.error) {
        errorMessage =  response.errorMessage ?? "An error occured";
      }
      notes = response.data;
      _titleController.text = notes.name;
      _descriptionController.text = notes.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Note title'),
                  ),
                  Container(height: 8),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(hintText: 'Note Description'),
                  ),
                  Container(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: RaisedButton(
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
