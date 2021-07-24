import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedr/screen/FolderContents/components/file_bottom_sheet.dart';
import 'package:seedr/provider/SeedrController.dart';

class FolderContentScreen extends StatefulWidget {
  const FolderContentScreen({Key? key}) : super(key: key);

  @override
  _FolderContentScreenState createState() => _FolderContentScreenState();
}

class _FolderContentScreenState extends State<FolderContentScreen> {
  @override
  Widget build(BuildContext context) {
    final _controller = context.watch<SeedrController>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: _controller.insideFolderitems.length,
        itemBuilder: (context, index) {
          var item = _controller.insideFolderitems[index];
          return Card(
            color: Colors.grey[900],
            elevation: 4,
            child: ListTile(
              onTap: () {
                // _controller.addTorrent(
                //     "magnet:?xt=urn:btih:1307346ce9eb49a36bc241a546720d53bbf2ffdc&dn=Black+Widow+%282021%29+%5B720p%5D+%5BWEBRip%5D+%5BYTS.MX%5D&xl=1288704264&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969%2Fannounce&tr=udp%3A%2F%2F9.rarbg.to%3A2710%2Fannounce&tr=udp%3A%2F%2Fp4p.arenabg.ch%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.cyberia.is%3A6969%2Fannounce&tr=http%3A%2F%2Fp4p.arenabg.com%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.internetwarriors.net%3A1337%2Fannounce");

                // var api = ApiService();
                // api.getFolderDownloadLink(179551320);

                // Delete File or folder
                // _controller.deleteTorrent(item["id"], type: "file");
                showFileModal(context);
              },
              leading: iconDedector(item),
              title: Text(
                _controller.insideFolderitems[index]["name"],
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    ));
  }
}

Widget iconDedector(item) {
  if (item["play_video"]) {
    return Icon(Icons.play_circle, color: Colors.red);
  }

  return Icon(Icons.text_snippet, color: Colors.yellow[200]);
}
