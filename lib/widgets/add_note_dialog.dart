import 'package:flutter/material.dart';
import 'package:organiser_app/theme/color_pallete.dart';

class AddNoteDialog extends StatelessWidget {
  final List<String> categories;
  final Function(String, String, String) onAddNote;

  const AddNoteDialog(
      {super.key, required this.categories, required this.onAddNote});

  @override
  Widget build(BuildContext context) {
    String selectedCategory = categories.length > 0 ? categories[0] : '';
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return AlertDialog(
      title: const Text('Add Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (value) {
              selectedCategory = value!;
            },
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            onChanged: (value) {},
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            onAddNote(selectedCategory, titleController.text,
                descriptionController.text);
          },
          child: const Text('Add Note'),
        ),
      ],
    );
  }
}
