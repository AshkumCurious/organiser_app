import 'package:flutter/material.dart';
import 'package:organiser_app/services/sql_service.dart';
import 'package:organiser_app/theme/color_pallete.dart';

import '../utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image taking half the screen
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/organise.jpg'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Curved container slightly overlapping the image
              Transform.translate(
                offset: const Offset(
                    0, -30), // Moves the container up to overlap the image
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        ColorPallete.primary.withOpacity(0.2),
                                    spreadRadius: 3,
                                    offset: const Offset(0, 2),
                                    blurRadius: 2)
                              ]),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.task_rounded,
                              color: ColorPallete.primary,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Hello User',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FutureBuilder(
                          future: _databaseService.getAllCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return GridView.builder(
                                padding: const EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      2, // number of items in each row
                                  mainAxisSpacing: 15, // spacing between rows
                                  crossAxisSpacing:
                                      15, // spacing between columns
                                ),
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var item = snapshot.data![index];
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorPallete.primary,
                                          ),
                                          child: Icon(
                                            categoryIcons[index],
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        Text(
                                          'Count: ${item.taskCount}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: ColorPallete.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
