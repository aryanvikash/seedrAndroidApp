import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showFolderModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Icon(Icons.copy),
              title: new Text('Copy Download Link'),
              onTap: () {
                Clipboard.setData(ClipboardData(text: "your text"));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              title: new Text('Delete'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
