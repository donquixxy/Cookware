import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          // scaffoldBackgroundColor: const Color.fromARGB(150, 40, 40, 40)
          // colorScheme: const ColorScheme(
          //     error: Colors.red,
          //     onSurface: Colors.green,
          //     background: Colors.blue,
          //     onPrimary: Colors.pink,
          //     secondary: Colors.amber,
          //     primary: Colors.blueGrey,
          //     onError: Colors.red,
          //     brightness: Brightness.light,
          //     onSecondary: Colors.teal,
          //     onBackground: Colors.cyan,
          //     surface: Colors.purple),
          // backgroundColor: Color.fromARGB(10, 15, 15, 30),
          ),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
