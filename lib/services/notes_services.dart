import 'dart:convert';

import 'package:testtodolist/models/api_response.dart';
import 'package:testtodolist/models/notes.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class NotesServices {
  static const API = 'https://4e53ba4c.ngrok.io/api';
  static const headers = {'Content-Type': 'application/json'};

  Future<APIResponse<List<Notes>>> getNoteList() async {
    return http.get(API + "/list").then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <Notes>[];

        for (var item in jsonData) {
          notes.add(Notes.fromJson(item));
        }

        return APIResponse<List<Notes>>(data: notes);
      }
      return APIResponse<List<Notes>>(
          error: true, errorMessage: 'An error occured 1');
    }).catchError((handleError) {
      return APIResponse<List<Notes>>(error: true, errorMessage: handleError);
    });
  }

  Future<APIResponse<Notes>> getNotes(String id) {
    return http.post(API + '/activities/' + id.toString()).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData["success"]);
        return APIResponse<Notes>(data: Notes.fromJson(jsonData["data"]));
      }
      return APIResponse<Notes>(
          error: true, errorMessage: '#3 An error occured');
    }).catchError((handleError) {
      return APIResponse<Notes>(error: true, errorMessage: '#4 An error occured');
    });
  }

  Future<APIResponse<bool>> createNote(Notes item) {
    return http.post(API + '/notes/create', body: jsonEncode(item.toJson())).then((data){

    });
  }
}
