import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Notes {
  int id;
  String name;
  String type;
  String description;

  Notes({this.id, this.name, this.type, this.description});

  factory Notes.fromJson(Map<String, dynamic> item) {
    return Notes(
        id: item['id'],
        name: item['name'],
        type: item['type'],
        description: item['description']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }

  @override
  String toString() {
    return 'Notes{id: $id, name: $name, type: $type, description: $description}';
  }

  List<Notes> notesFromJson(String jsonData) {
    final data = jsonDecode(jsonData);
    return List<Notes>.from(data.map((item) => Notes.fromJson(item)));
  }

  String notesToJson(Notes data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }
}
