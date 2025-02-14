import 'package:flutter/material.dart';

import 'core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: appTheme,
      home: inherited(testColor: getRandomColor(), child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData t = MediaQuery.of(context);
    final access = inherited.of(context);

    return Scaffold(
      body: Container(
        color: access.testColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.change_circle),
      ),
    );
  }
}

Color getRandomColor() {
  List colorsList = [
    Colors.red,
    Colors.black,
    Colors.blue,
    Colors.grey,
  ];
  colorsList.shuffle();
  return colorsList.first;
}

class inherited extends InheritedWidget {
  inherited({super.key, required super.child, required this.testColor});

  final testColor;

  static inherited of(BuildContext context) {
    inherited? object = context.dependOnInheritedWidgetOfExactType<inherited>();
    return object!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw true;
  }

  List<int> a = [1, 2, 3, 5];

  int getSumDeclarative(List r) {
    return r.reduce((prev, curr) => prev + curr);
  }

  int getSumImperative(List r) {
    int sum1 = 0;
    r.forEach((sum) => sum1 = sum + sum1);
    return sum1;
  }
}
