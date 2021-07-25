import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seedr/provider/SeedrController.dart';
import 'package:seedr/services/Api.dart';

showFileModal(BuildContext context, item) {
  print(item);
  SeedrController _controller = context.read<SeedrController>();
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Icon(Icons.copy),
              title: new Text('Copy Link To Clipboard'),
              onTap: () async {
                try {
                  if (item["isfile"] ?? false) {
                    var url = await _controller
                        .getFileDownloadLink(item["folder_file_id"]);
                    Clipboard.setData(ClipboardData(text: url.toString()));
                    _controller.showToast("link Copied to Clipboard");
                    Navigator.pop(context);
                  }

                  _controller.showToast("Not a file", type: "error");
                } catch (e) {
                  print(e);
                  _controller.showToast(e.toString());
                }
              },
            ),
            ListTile(
              leading: new Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              title: new Text('Delete'),
              onTap: () {
                if (item["isfile"] ?? false) {
                  _controller.delete(item["folder_file_id"], ItemType.file);
                } else {
                  _controller.delete(item["id"], ItemType.folder);
                }
                _controller.getFolderContents(_controller.currentFolderId);

                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
