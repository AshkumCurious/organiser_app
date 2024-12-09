import 'package:flutter/material.dart';
import 'package:organiser_app/theme/color_pallete.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: ColorPallete.primary.withOpacity(0.2),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recents",
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorPallete.primary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: ColorPallete.primary,
                          size: 15,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorPallete.cardbgcolor,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.all(15),
                              child: Text("Task"),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
