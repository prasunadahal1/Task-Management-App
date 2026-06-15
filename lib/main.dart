import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/task_providers.dart';
import 'package:task_app/resources/main_screen.dart';
import 'package:task_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home:SplashScreen(),
      ),
    );
  }
}

