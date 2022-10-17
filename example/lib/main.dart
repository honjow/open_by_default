import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:open_by_default/open_by_default.dart';

void main() {
  SystemUiOverlayStyle uiStyle = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
  );

  SystemChrome.setSystemUIOverlayStyle(uiStyle);

  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
      theme: ThemeData(
          // brightness: Brightness.dark,
          // primaryColor: Colors.red[100],
          // appBarTheme: AppBarTheme.of(context).copyWith(
          //   // 方式1
          //   color: Colors.white,
          //
          // ),
          ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('open_by_default example app'),
          // backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextButton(
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
