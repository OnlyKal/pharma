import 'dart:async';
import 'package:flutter/material.dart';
import './export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/home': (context) => const Home(),
        '/detail': (context) => const Details(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 70, 64),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Pharma',
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Lab',
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              const Text(
                'Gestion de la logistique medicale',
                style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 6, 202, 183),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ));
  }
}
