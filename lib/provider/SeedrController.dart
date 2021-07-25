import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seedr/services/Api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SeedrController extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  List Allfolders = [];

  var insideFolderitems = [];
  var api = ApiService();
  var currentFolderId = 0;

  Future fetchAllFolder() async {
    api.ListFolderItems("178129190");
    var data = await api.fetchfiles();

    Allfolders.clear();
    try {
      data["folders"]?.forEach((folder) {
        folder["isfolder"] = true;
        Allfolders.add(folder);
      });
      data["files"]?.forEach((file) {
        file["isfile"] = true;
        Allfolders.add(file);
      });

      data["torrents"].forEach((torrent) {
        torrent["istorrent"] = true;
        print(torrent);
        Allfolders.add(torrent);
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getFolderContents(folderId) async {
    currentFolderId = folderId;

    try {
      insideFolderitems.clear();
      var items = await api.ListFolderItems(folderId);

      items["folders"].forEach((item) {
        item["isfolder"] = true;
        insideFolderitems.add(item);
      });

      items["files"].forEach((item) {
        item["isfile"] = true;
        insideFolderitems.add(item);
      });

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future getFileDownloadLink(id) async {
    print(id);
    try {
      var res = await api.getFileDownloadLink(id);
      return res["url"];
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
    fetchAllFolder();
  }

  getFolderLinks(id) async {
    try {
      var res = await api.getFolderDownloadLink(id);
      
      return res["archive_url"];
    } catch (e) {
      showToast(e, type: "error");
    }
  }

  delete(id, ItemType itemtype) async {
    try {
      var res = await api.delete(id, itemtype);
      print(res);
      showToast("Deleted Successfully");
    } catch (e) {
      showToast(e.toString(), type: "error");
    }
  }

  showToast(message, {String type = "success"}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: type == "error" ? Colors.redAccent : Colors.green,
        textColor: Colors.white,
        fontSize: 18.0);
  }
}
