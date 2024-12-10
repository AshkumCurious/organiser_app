import 'package:flutter/material.dart';
import 'package:organiser_app/theme/color_pallete.dart';
import 'package:organiser_app/widgets/note_card.dart';

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
    fetchCategories();
    super.initState();
  }

  fetchCategories() async {}
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: ColorPallete.cardbgcolor,
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
              _databaseService.addNote(
                categoryid: 3,
                title: 'Title 1',
                description:
                    'This is a new note that I have created for reference and this is how i can see it in the app',
              );
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                FutureBuilder(
                  future: _databaseService.getNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // Use snapshot.data[index] to access each category
                          return NotesCard(
                            title: snapshot.data![index].title,
                            description: snapshot.data![index].description,
                            type: snapshot.data![index].categoryId,
                            dateTime: snapshot.data![index].createdAt,
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
