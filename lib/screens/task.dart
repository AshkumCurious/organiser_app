import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organiser_app/theme/color_pallete.dart';
import 'package:organiser_app/widgets/note_card.dart';
import 'package:provider/provider.dart';

import '../provider/note_provider.dart';
import '../services/sql_service.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  // final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: ColorPallete.cardbgcolor,
        actions: [
          IconButton(
            onPressed: () {},
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
                        itemCount:
                            Provider.of<NoteProvider>(context).notes.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // Use snapshot.data[index] to access each category
                          var note =
                              Provider.of<NoteProvider>(context).notes[index];
                          return NotesCard(
                            title: note.title,
                            description: note.description,
                            type: note.categoryId,
                            dateTime: note.createdAt,
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
}
