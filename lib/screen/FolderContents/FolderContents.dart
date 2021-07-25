import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedr/helper/utils.dart';
import 'package:seedr/screen/FolderContents/components/file_bottom_sheet.dart';
import 'package:seedr/provider/SeedrController.dart';
import 'package:seedr/screen/HomeFiles/components/FolderBottomModal.dart';

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
      body: RefreshIndicator(
        onRefresh: () =>
            _controller.getFolderContents(_controller.currentFolderId),
        child: ListView.builder(
          itemCount: _controller.insideFolderitems.length,
          itemBuilder: (context, index) {
            var item = _controller.insideFolderitems[index];
            return Card(
              color: Colors.grey[900],
              elevation: 4,
              child: ListTile(
                onTap: () async {
                  if (item["isfolder"] ?? false) {
                    print(item);
                    await _controller.getFolderContents(item["id"]);
                    return;
                  }
                  showFileModal(context, item);
                },
                leading: iconDedector(item),
                trailing: IconButton(
                    onPressed: () {
                      if (item["isfile"] ?? false) {
                        showFileModal(context, item);
                        return;
                      }
                      showFolderModal(context, item);
                    },
                    icon: Icon(Icons.more_vert, color: Colors.white)),
                title: Text(
                  _controller.insideFolderitems[index]["name"],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
