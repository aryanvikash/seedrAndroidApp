import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:seedr/WebView.dart';
import 'package:seedr/provider/SeedrController.dart';
import 'package:seedr/screen/FolderContents/FolderContents.dart';
import 'package:seedr/screen/SpalashScreen.dart';
import 'package:seedr/screen/HomeFiles/files.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("seedr");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SeedrController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var api = ApiService();
    // api.fetchfiles();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpalashScreen(),
      routes: {
        '/contents': (_) => FolderContentScreen(),
        '/weblogin': (_) => CustomWebView(),
        '/files': (context) => FilesScreen(),
      },
    );
  }
}
