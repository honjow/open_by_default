import 'package:flutter/material.dart';

import 'package:open_by_default/open_by_default.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: TextButton(
            child: Text('open_by_default'),
            onPressed: OpenByDefault.open,
          ),
        ),
      ),
    );
  }
}
