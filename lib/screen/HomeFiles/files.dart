import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:seedr/SharedComponents/ParentFab.dart';
import 'package:seedr/helper/utils.dart';
import 'package:seedr/provider/SeedrController.dart';
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
            body: ListView.builder(
              itemCount: context.watch<SeedrController>().Allfolders.length,
              itemBuilder: (context, index) => Card(
                color: Colors.grey[900],
                shadowColor: Colors.white,
                elevation: 2,
                child: ListTile(
                  trailing: IconButton(
                    onPressed: () => showFolderModal(context),
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                      _controller.Allfolders[index]["play_video"]
                          ? Icons.play_arrow
                          : Icons.folder,
                      color: Colors.redAccent),
                  title: Text(
                    _controller.Allfolders[index]["name"],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    getFileSize(_controller.Allfolders[index]["size"]),
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _controller
                        .getFolderContents(_controller.Allfolders[index]["id"]);
                    Navigator.pushNamed(context, "/contents");
                  },
                ),
              ),
            )),
      ),
    );
  }
}
