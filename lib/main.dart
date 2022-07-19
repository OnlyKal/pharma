import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharma/color.dart';
import './export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'KARA',
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: maincolor),
                  ),
                  Text(
                    'PHAR',
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w200,
                        color: maincolor),
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
                    color: maincolor,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ));
  }
}
