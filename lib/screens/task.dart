import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organiser_app/models/note_model.dart';
import 'package:organiser_app/theme/color_pallete.dart';
import 'package:organiser_app/widgets/note_card.dart';
import 'package:provider/provider.dart';
import '../provider/note_provider.dart';
import '../provider/category_provider.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<int> _selectedCategories = [];
  bool _selectAll = false;
  List<int> _previousSelectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: ColorPallete.cardbgcolor,
        actions: [
          IconButton(
            onPressed: () => _showMultiSelectDialog(context),
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.1),
        child: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: ColorPallete.primary,
              size: 30,
            ),
            onPressed: () async {
              GoRouter.of(context).push('/tasks/addnote');
            }),
      ),
      body: SafeArea(
        child: Provider.of<NoteProvider>(context).isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: Provider.of<NoteProvider>(context)
                            .filteredNotes(_selectedCategories)
                            .length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var note = Provider.of<NoteProvider>(context)
                              .filteredNotes(_selectedCategories)[index];
                          return InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .push('/tasks/addnote', extra: note.toMap());
                            },
                            child: NotesCard(
                              title: note.title,
                              description: note.description,
                              type: note.categoryId,
                              dateTime: note.updatedAt,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _showMultiSelectDialog(BuildContext context) {
    final categories =
        Provider.of<CategoryProvider>(context, listen: false).categories;

    _previousSelectedCategories = List.from(_selectedCategories);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Categories'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text('All'),
                      value: _selectAll,
                      onChanged: (value) {
                        setDialogState(() {
                          _selectAll = value ?? false;
                          if (_selectAll) {
                            _selectedCategories = categories
                                .map((category) => category.id ?? -1)
                                .whereType<int>()
                                .toList();
                          } else {
                            _selectedCategories.clear();
                          }
                        });
                      },
                    ),
                    ...categories.map((category) {
                      return CheckboxListTile(
                        title: Text(category.name),
                        value: _selectedCategories.contains(category.id),
                        onChanged: (value) {
                          setDialogState(() {
                            if (value == true) {
                              if (category.id != null) {
                                _selectedCategories.add(category.id!);
                              }
                              if (_selectedCategories.length ==
                                  categories.length) {
                                _selectAll = true;
                              }
                            } else {
                              _selectedCategories.remove(category.id);
                              _selectAll = false;
                            }
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategories =
                          List.from(_previousSelectedCategories);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

extension NoteFiltering on NoteProvider {
  List<Note> filteredNotes(List<int> selectedCategories) {
    if (selectedCategories.isEmpty) return notes;
    return notes
        .where((note) => selectedCategories.contains(note.categoryId))
        .toList();
  }
}
