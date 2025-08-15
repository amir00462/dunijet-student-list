import 'package:flutter/material.dart';
import 'package:mockapi_flutter/constants.dart';
import 'package:mockapi_flutter/screens/user_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dunijet Student List',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const UsersListScreen(),
    );
  }
}
