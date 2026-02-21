import 'package:flutter/material.dart';
import 'screens/users_screen.dart';

//app entry point. Starts the Flutter application.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Root app configuration: Theme +initial route.
      title: 'Axscend Flutter Task',
      theme: ThemeData(
        // Material 3 enables modern UI components like SegmentedButton.
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      // Start the app on the Users list screen.
      home: const UsersScreen(),
    );
  }
}