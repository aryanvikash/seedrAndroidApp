import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seedr/services/Api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SeedrController extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  List Allfolders = [];

  var insideFolderitems = [];
  var api = ApiService();

  void fetchAllFolder() async {
    Allfolders.clear();
    api.ListFolderItems("178129190");
    var data = await api.fetchfiles();

    try {
      data["folders"]?.forEach((folder) => Allfolders.add(folder));
      data["files"]?.forEach((file) => Allfolders.add(file));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getFolderContents(folderId) async {
    try {
      insideFolderitems.clear();
      var items = await api.ListFolderItems(folderId);

      items["folders"].forEach((item) => insideFolderitems.add(item));
      items["files"].forEach((item) => insideFolderitems.add(item));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future getFileDownloadLink(id) async {
    try {
      var res = await api.getFileDownloadLink(id);
      return res.url;
    } catch (e) {
      showToast(e);
    }
  }

  addTorrent(magnet) async {
    var res = await api.addTorrent(magnet);
    print(res);
    if (res["result"] == "parsing_error") {
      showToast("Failed To add Your Torrent", type: "error");
      return;
    }
    showToast("${res["title"]} added");
  }

  deleteTorrent(id, {type = "folder"}) async {
    var res = await api.deleteItem(id);
    print(res);
    showToast(res["result"].toString());
  }

  showToast(message, {String type = "success"}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor:
            type == "error" ? Colors.redAccent : Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
