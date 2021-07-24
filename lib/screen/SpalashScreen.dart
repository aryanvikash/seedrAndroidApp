import 'package:flutter/material.dart';
import 'package:seedr/services/Api.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  _SpalashScreenState createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  final api = ApiService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/images/logo.png"),
            FutureBuilder(
              future: api.isLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  if (snapshot.data == true) {
                    WidgetsBinding.instance!.addPostFrameCallback(
                        (_) => Navigator.popAndPushNamed(context, "/files"));
                  } else {
                    WidgetsBinding.instance!.addPostFrameCallback(
                        (_) => Navigator.popAndPushNamed(context, "/weblogin"));
                  }
                }
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
