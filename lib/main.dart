import 'package:flutter/material.dart';
import 'package:growdev_desafio_fase2/pages/home.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Growdev Fase 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 1, 27, 114),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
