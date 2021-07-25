import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seedr/provider/SeedrController.dart';
import "package:provider/provider.dart";
import 'package:seedr/services/Api.dart';

showFolderModal(BuildContext context, item) {
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
                if (item["istorrent"] ?? false) {
                  _controller.showToast("File still downloading");
                } else if (item["isfolder"] ?? false) {
                  var url = await _controller.getFolderLinks(item["id"]);
                  Clipboard.setData(ClipboardData(text: url));
                  _controller.showToast("Copied To clipboard");
                } else {
                  var url = await _controller
                      .getFileDownloadLink(item["folder_file_id"]);
                  Clipboard.setData(ClipboardData(text: url));
                  _controller.showToast("Copied To clipboard");
                }

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              title: new Text('Delete'),
              onTap: () async {
                if (item["isfile"] ?? false) {
                  _controller.delete(item["folder_file_id"], ItemType.file);
                } else if (item["istorrent"] ?? false) {
                  _controller.delete(item["id"], ItemType.torrent);
                } else {
                  _controller.delete(item["id"], ItemType.folder);
                }
                print("deleted now refreshing");
                await _controller.fetchAllFolder();
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
