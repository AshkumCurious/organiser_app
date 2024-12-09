import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organiser_app/screens/extra.dart';
import 'package:organiser_app/screens/home.dart';
import 'package:organiser_app/screens/task.dart';
import 'package:organiser_app/widgets/bottom_navbar.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter router(BuildContext context) => GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
            builder: (context, state, child) {
              return BottomNavBar(child: child);
            },
            routes: [
              GoRoute(path: '/', builder: (context, state) => const Home()),
              GoRoute(
                  path: '/tasks', builder: (context, state) => const Tasks()),
              GoRoute(
                  path: '/extra', builder: (context, state) => const Extra()),
            ]),
      ],
      errorBuilder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text('Page not found: ${state.uri}'),
          ),
        );
      },
    );
