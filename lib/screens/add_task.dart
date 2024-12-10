import 'package:flutter/material.dart';
import 'package:organiser_app/theme/color_pallete.dart';

import '../utils/constants.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPallete.cardbgcolor,
        title: const Text(
          'Add New Note',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTitleField(),
                const SizedBox(height: 20),
                _buildContentField(),
                const SizedBox(height: 20),
                _buildCategoryDropdown(),
                const SizedBox(height: 30),
                _buildAddButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Title',
        labelStyle: TextStyle(color: ColorPallete.primary),
        hintText: 'Enter note title',
        prefixIcon: Icon(Icons.title, color: ColorPallete.primary),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: ColorPallete.primary.withOpacity(0.3), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorPallete.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Title cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _buildContentField() {
    return TextFormField(
      controller: _contentController,
      maxLines: 6,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: 'Content',
        labelStyle: TextStyle(color: ColorPallete.primary),
        hintText: 'Write your note here...',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Icon(Icons.notes, color: ColorPallete.primary),
        ),
        // contentPadding:
        //     const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: ColorPallete.primary.withOpacity(0.3), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorPallete.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Content cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category',
        labelStyle: TextStyle(color: ColorPallete.primary),
        prefixIcon: Icon(Icons.category, color: ColorPallete.primary),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: ColorPallete.primary.withOpacity(0.3), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorPallete.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(
            category,
            style: TextStyle(color: ColorPallete.primary),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _submitTask,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPallete.primary.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      child: const Text(
        'Add Note',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _submitTask() {
    if (_validateForm()) {
      Navigator.pop(context);
    }
  }

  bool _validateForm() {
    final titleValid = _titleController.text.isNotEmpty;
    final contentValid = _contentController.text.isNotEmpty;
    final categoryValid = _selectedCategory != null;

    if (!titleValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a title'),
          backgroundColor: ColorPallete.primary,
          showCloseIcon: true,
        ),
      );
    } else if (!contentValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter content'),
          backgroundColor: ColorPallete.primary,
          showCloseIcon: true,
        ),
      );
    } else if (!categoryValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a category'),
          backgroundColor: ColorPallete.primary,
          showCloseIcon: true,
        ),
      );
    }

    return titleValid && contentValid && categoryValid;
  }
}
