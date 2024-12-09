import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organiser_app/services/gorouter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final GoRouter _router = router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
