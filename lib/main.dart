import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatdo/database/todo.db.dart';
import 'package:whatdo/pages/MainPage.dart';
import 'package:whatdo/themes/theme_provider.dart';


void main () async {
 WidgetsFlutterBinding.ensureInitialized();
  await TodoDb.initialize();
TodoDb todoDb = TodoDb();
 runApp( 
     MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) =>todoDb),
        ChangeNotifierProvider( create: (context) =>ThemeProvider()),
 ], child: const MyApp())
);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.w
  @override
Widget build(BuildContext context) {
    return MaterialApp(
title: 'Todo App',
      debugShowCheckedModeBanner: false,
      home:  const MainPage(),
      theme: Provider.of<ThemeProvider>(context).themeData 
    );
  }
}

