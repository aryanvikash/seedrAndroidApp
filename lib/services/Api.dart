import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seedr/constants.dart';

class ApiService {
  late Dio dio;
  late Box db;
  late String token;
  var options;

  var _listContent = {
    'content_type': 'folder',
    'content_id': 0,
  };

  ApiService() {
    this.db = Hive.box("seedr");
    this.token = db.get("token") ?? "";
    this.options = BaseOptions(
        headers: {
          'Cookie': db.get("token") ?? "",
          'User-Agent': AndroidUserAgent
        },
        baseUrl: base_url + "content.php?action=",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        connectTimeout: 5000,
        sendTimeout: 5000);
    this.dio = Dio(this.options);
  }

  Future fetchfiles() async {
    print(db.get("token"));
    try {
      Response response =
          await this.dio.post("list_contents", data: _listContent);

      // print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future getFolderDownloadLink(int id) async {
    var res = await dio.post("create_empty_archive", data: {
      "archive_arr": jsonEncode([
        {"type": "folder", "id": id}
      ])
    });

    print(res.data);

    return res.data;
  }

  // ignore: non_constant_identifier_names
  Future ListFolderItems(folderId) async {
    try {
      var res = await dio.post("list_contents",
          data: {"content_id": folderId.toString(), "content-type": "folder"});

      print(res.data);
      return res.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getFileDownloadLink(id) async {
    var res = await dio.post("fetch_file", data: {"folder_file_id": id});
    return res.data;
  }

  Future addTorrent(magnet) async {
    var res = await dio.post("add_torrent",
        data: {"torrent_magnet": magnet, "folder_id": "-1"});

    // if (res.data["code"] != 200) {
    //   throw Exception(res.data);
    // }
    return res.data;
  }

  deleteItem(id, {type = "folder"}) async {
    var res = await dio.post("delete", data: {
      "delete_arr": jsonEncode([
        {"type": type, "id": id}
      ])
    });
    return res.data;
  }

  Future<bool> isLoggedIn() async {
    print("checking Logging status");
    var res = await dio.get("get_settings");
    late var data;
    try {
      data = jsonDecode(res.data);
    } catch (e) {
      data = res.data;
    }

    try {
      if (data["result"] == "login_required") {
        print("login first");
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
