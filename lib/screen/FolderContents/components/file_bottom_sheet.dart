import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seedr/provider/SeedrController.dart';

showFileModal(BuildContext context) {
  SeedrController _controller = context.read<SeedrController>();
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Icon(Icons.copy),
              title: new Text('Copy Download Link'),
              onTap: () async {
                try {
                  var url = await _controller.getFileDownloadLink(963486891);
                  Clipboard.setData(ClipboardData(text: url.toString()));
                  Navigator.pop(context);
                } catch (e) {
                  _controller.showToast(e);
                }
              },
            ),
            ListTile(
              leading: new Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              title: new Text('Delete File'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
