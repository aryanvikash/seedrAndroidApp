import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:seedr/SharedComponents/ParentFab.dart';
import 'package:seedr/helper/utils.dart';
import 'package:seedr/provider/SeedrController.dart';
import 'package:seedr/screen/FolderContents/components/file_bottom_sheet.dart';
import 'package:seedr/screen/HomeFiles/components/FolderBottomModal.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  var box = Hive.box("seedr");

  @override
  void initState() {
    super.initState();
    context.read<SeedrController>().fetchAllFolder();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = context.watch<SeedrController>();
    return SafeArea(
      child: MyParent(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: RefreshIndicator(
              onRefresh: () => _controller.fetchAllFolder(),
              child: ListView.builder(
                itemCount: context.watch<SeedrController>().Allfolders.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey[900],
                  shadowColor: Colors.white,
                  elevation: 2,
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () => showFolderModal(
                          context, _controller.Allfolders[index]),
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                    leading: iconDedector(_controller.Allfolders[index]),
                    title: Text(
                      _controller.Allfolders[index]["name"],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Container(
                        margin: EdgeInsets.only(top: 15),
                        child:
                            descriptionHandler(_controller.Allfolders[index])),
                    onTap: () {
                      var item = _controller.Allfolders[index];

                      if (item["isfile"] ?? false) {
                        showFileModal(context, item);
                        return;
                      }
                      _controller.getFolderContents(
                          _controller.Allfolders[index]["id"]);
                      Navigator.pushNamed(context, "/contents");
                    },
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

Widget descriptionHandler(item) {
  if (item["istorrent"] ?? false) {
    return Wrap(
      spacing: 15,
      runSpacing: 10,
      children: [
        Text(getFileSize(item["size"]), style: TextStyle(color: Colors.blue)),
        Text("Speed : " + getFileSize(item["download_rate"]),
            style: TextStyle(color: Colors.blue)),
        Text("progress " + item["progress"] + "%",
            style: TextStyle(color: Colors.blue)),
        Text("seeders\t" + item["seeders"].toString(),
            style: TextStyle(color: Colors.blue)),
        Text(jsonDecode(item["warnings"])[0] ?? null,
            style: TextStyle(color: Colors.yellow)),
        Text(
          item["stopped"] == 1 ? "Stopped" : "Downloading",
          style: TextStyle(
              color: item["stopped"] == 1 ? Colors.red : Colors.green),
        ),
      ],
    );
  }
  return Text(
    getFileSize(item["size"]),
    style: TextStyle(color: Colors.blue),
  );
}
