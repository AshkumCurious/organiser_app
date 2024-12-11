import 'package:flutter/material.dart';
import 'package:organiser_app/models/note_model.dart';
import 'package:organiser_app/provider/category_provider.dart';
import 'package:organiser_app/services/gorouter.dart';
import 'package:provider/provider.dart';

import '../services/sql_service.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final DatabaseService _databaseService = DatabaseService.instance;

  NoteProvider() {
    fetchNotes();
  }

  void fetchNotes() async {
    _isLoading = true;
    await _databaseService.getNotes().then((value) {
      _notes = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  void addNote({
    required String title,
    required String content,
    required int category,
  }) async {
    _databaseService.addNote(
      categoryid: category,
      title: title,
      description: content,
    );
    fetchNotes();
    Provider.of<CategoryProvider>(navigatorKey.currentContext!, listen: false)
        .fetchCategories();
  }
}
