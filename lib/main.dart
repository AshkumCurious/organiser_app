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
  late GoRouter _router;
  @override
  void initState() {
    _router = router(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[100], fontFamily: "Poppins"),
    );
  }
}
