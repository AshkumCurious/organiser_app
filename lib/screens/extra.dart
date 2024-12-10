import 'package:flutter/material.dart';

class Extra extends StatefulWidget {
  const Extra({super.key});

  @override
  State<Extra> createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Coming soon'),
        ),
      ),
    );
  }
}
