import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organiser_app/models/note_model.dart';
import 'package:organiser_app/provider/category_provider.dart';
import 'package:organiser_app/theme/color_pallete.dart';
import 'package:provider/provider.dart';

import '../provider/note_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, required this.taskdata});
  final Map taskdata;
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  int? _selectedCategory;

  @override
  void initState() {
    if (widget.taskdata.isNotEmpty) {
      print(widget.taskdata);
      setState(() {
        _titleController.text = widget.taskdata['title'];
        _contentController.text = widget.taskdata['description'];
        _selectedCategory = widget.taskdata['categoryId'];
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPallete.cardbgcolor,
        title: Text(
          (widget.taskdata.isEmpty) ? 'Add New Note' : 'Edit Note',
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
      keyboardType: TextInputType.text,
      inputFormatters: [LengthLimitingTextInputFormatter(50)],
      textCapitalization: TextCapitalization.sentences,
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
        } else if (value.length < 3) {
          return 'Title must be at least 3 characters';
        } else if (value.length > 50) {
          return 'Title must be at most 50 characters';
        }
        return null;
      },
    );
  }

  Widget _buildContentField() {
    return TextFormField(
      controller: _contentController,
      maxLines: 15,
      textAlignVertical: TextAlignVertical.top,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: 'Content',
        labelStyle: TextStyle(color: ColorPallete.primary),
        hintText: 'Write your note here...',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(bottom: 280),
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
    return DropdownButtonFormField(
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
      items: Provider.of<CategoryProvider>(context).categories.map((category) {
        return DropdownMenuItem(
          value: category.id,
          child: Text(
            category.name,
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
      child: Text(
        (widget.taskdata.isEmpty) ? 'Add Note' : 'Edit Note',
        style: const TextStyle(
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
      if (widget.taskdata.isNotEmpty) {
        Provider.of<NoteProvider>(context, listen: false).updateNote(
          id: widget.taskdata['id'],
          title: _titleController.text,
          content: _contentController.text,
          category: _selectedCategory!,
          oldCaategoryId: widget.taskdata['categoryId'],
        );
      } else {
        Provider.of<NoteProvider>(context, listen: false).addNote(
          title: _titleController.text,
          content: _contentController.text,
          category: _selectedCategory!,
        );
      }
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
