// To parse this JSON data, do
//
//     final filesModel = filesModelFromJson(jsonString);

import 'dart:convert';

FilesModel filesModelFromJson(String str) =>
    FilesModel.fromJson(json.decode(str));

String filesModelToJson(FilesModel data) => json.encode(data.toJson());

class FilesModel {
  FilesModel({
    this.spaceMax,
    this.spaceUsed,
    this.sawWalkthrough,
    this.t,
    this.timestamp,
    this.folderId,
    this.fullname,
    this.type,
    this.name,
    this.parent,
    this.indexes,
    this.torrents,
    this.folders,
    this.files,
  });

  String? spaceMax;
  String? spaceUsed;
  int? sawWalkthrough;
  List<String>? t;
  DateTime? timestamp;
  String? folderId;
  String? fullname;
  String? type;
  String? name;
  String? parent;
  List<dynamic>? indexes;
  List<dynamic>? torrents;
  List<Folder>? folders;
  List<dynamic>? files;

  factory FilesModel.fromJson(Map<String, dynamic> json) => FilesModel(
        spaceMax: json["space_max"],
        spaceUsed: json["space_used"],
        sawWalkthrough: json["saw_walkthrough"],
        t: List<String>.from(json["t"].map((x) => x)),
        timestamp: DateTime.parse(json["timestamp"]),
        folderId: json["folder_id"],
        fullname: json["fullname"],
        type: json["type"],
        name: json["name"],
        parent: json["parent"],
        indexes: List<dynamic>.from(json["indexes"].map((x) => x)),
        torrents: List<dynamic>.from(json["torrents"].map((x) => x)),
        folders:
            List<Folder>.from(json["folders"].map((x) => Folder.fromJson(x))),
        files: List<dynamic>.from(json["files"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "space_max": spaceMax,
        "space_used": spaceUsed,
        "saw_walkthrough": sawWalkthrough,
        "t": List<dynamic>.from(t!.map((x) => x)),
        "timestamp": timestamp!.toIso8601String(),
        "folder_id": folderId,
        "fullname": fullname,
        "type": type,
        "name": name,
        "parent": parent,
        "indexes": List<dynamic>.from(indexes!.map((x) => x)),
        "torrents": List<dynamic>.from(torrents!.map((x) => x)),
        "folders": List<dynamic>.from(folders!.map((x) => x.toJson())),
        "files": List<dynamic>.from(files!.map((x) => x)),
      };
}

class Folder {
  Folder({
    this.id,
    this.name,
    this.fullname,
    this.size,
    this.playAudio,
    this.playVideo,
    this.isShared,
    this.lastUpdate,
  });

  String? id;
  String? name;
  String? fullname;
  String? size;
  bool? playAudio;
  bool? playVideo;
  bool? isShared;
  DateTime? lastUpdate;

  factory Folder.fromJson(Map<String, dynamic> json) => Folder(
        id: json["id"],
        name: json["name"],
        fullname: json["fullname"],
        size: json["size"],
        playAudio: json["play_audio"],
        playVideo: json["play_video"],
        isShared: json["is_shared"],
        lastUpdate: DateTime.parse(json["last_update"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fullname": fullname,
        "size": size,
        "play_audio": playAudio,
        "play_video": playVideo,
        "is_shared": isShared,
        "last_update": lastUpdate!.toIso8601String(),
      };
}
