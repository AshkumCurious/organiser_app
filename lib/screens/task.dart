import 'package:flutter/material.dart';
import 'package:organiser_app/theme/color_pallete.dart';
import 'package:organiser_app/utils/constants.dart';
import 'package:organiser_app/widgets/add_note_dialog.dart';

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
              // _databaseService.addNote(
              //   categoryid: 1,
              //   title: 'Task 1',
              //   description: 'Description 1',
              // );
              showDialog(
                  context: context,
                  builder: (context) => AddNoteDialog(
                        categories: categories,
                        onAddNote: (p0, p1, p2) {},
                      ));
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
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
                        return ListTile(
                          title: Text('Task $index'),
                          subtitle: Text('Description $index'),
                          leading: CircleAvatar(
                            child: Text('$index'),
                          ),
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
    );
  }
}
