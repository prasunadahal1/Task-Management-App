import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/task_providers.dart';
import 'package:task_app/providers/session_management.dart';
import 'package:task_app/resources/main_screen.dart';
import 'package:task_app/screens/splash_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> TaskProvider(),),
         ChangeNotifierProvider(create: (context)=> SessionManagement()),
      ],
      child:Builder(builder: (BuildContext context){
        return Consumer<TaskProvider>(
          builder: (context,provider,_){
            return   MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: provider.isDarkMode? ThemeMode.dark:ThemeMode.light,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              home:SplashScreen(),
            );
          },
        );
      },)
    );
  }
}

