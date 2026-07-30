import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/Routes/Admin_Routes/admin_routes_generator.dart';
import 'package:task_app/admin_screen/admin_dashboard.dart';
import 'package:task_app/providers/admin_provider/admin_dashboard_provider.dart';
import 'package:task_app/providers/user_provider/task_providers.dart';
import 'package:task_app/providers/user_provider/session_management.dart';
import 'package:task_app/resources/main_screen.dart';
import 'package:task_app/user_screen/splash_screen.dart';

import 'Routes/Admin_Routes/admin_route.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName:".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
   anonKey: dotenv.env['ANON_KEY']!
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> TaskProvider()),
        ChangeNotifierProvider(create: (context)=> AdminDashboardProvider()),
         ChangeNotifierProvider(create: (_) => SessionManagement.instance),
      ],
      child:Builder(builder: (BuildContext context){
        return Consumer<TaskProvider>(
          builder: (context,provider,_){
            return   MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              // initialRoute: Routes.adminDashboardScreen,
              // onGenerateRoute: AdminRoutesGenerator.generateRoute,
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

