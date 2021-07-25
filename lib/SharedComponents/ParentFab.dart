import 'package:flutter/material.dart';
import 'package:seedr/screen/HomeFiles/components/AddTorrentDialog.dart';

class MyParent extends StatelessWidget {
  final Widget child;
  const MyParent({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SeedrController _controller = context.read<SeedrController>();
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          bottom: 0,
          right: 0,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue[900],
            label: Text("Add"),
            icon: Icon(Icons.add),
            onPressed: () async {
              await ShowTorrentDialog(context);
            },
          ),
        )
      ],
    );
  }
}
