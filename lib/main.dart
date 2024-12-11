import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organiser_app/provider/category_provider.dart';
import 'package:organiser_app/services/gorouter.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter _router;
  @override
  void initState() {
    _router = router(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[100], fontFamily: "Poppins"),
      ),
    );
  }
}
