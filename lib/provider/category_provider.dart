import 'package:flutter/material.dart';
import 'package:organiser_app/models/category_model.dart';

import '../services/sql_service.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;
  final DatabaseService _databaseService = DatabaseService.instance;

  CategoryProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    await _databaseService.getAllCategories().then((value) {
      _categories = value;
      notifyListeners();
    });
    notifyListeners();
  }
}
