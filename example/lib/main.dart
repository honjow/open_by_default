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
  Map<String, DomainVerificationUserState>? domains;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('open_by_default example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('open_by_default'),
                  onPressed: OpenByDefault.open,
                ),
                TextButton(
                  child: Text('getAllDomains'),
                  onPressed: () async {
                    domains = await OpenByDefault.getAllDomains();
                    print(domains);
                    setState(() {});
                  },
                ),
                TextButton(
                  child: Text('getVerifiedDomains'),
                  onPressed: () async {
                    domains = await OpenByDefault.getVerifiedDomains();
                    print(domains);
                    setState(() {});
                  },
                ),
                TextButton(
                  child: Text('getSelectedDomains'),
                  onPressed: () async {
                    domains = await OpenByDefault.getSelectedDomains();
                    print(domains);
                    setState(() {});
                  },
                ),
                TextButton(
                  child: Text('getUnapprovedDomains'),
                  onPressed: () async {
                    domains = await OpenByDefault.getUnapprovedDomains();
                    print(domains);
                    setState(() {});
                  },
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      'domains:\n${domains?.entries.map((e) => '${e.key}: ${e.value}').join('\n') ?? ''}'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
