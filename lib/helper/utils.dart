import 'dart:math';
import 'package:mime/mime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String getFileSize(int bytes) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i];
}

// ignore: non_constant_identifier_names

Widget iconDedector(Map<dynamic, dynamic> item) {
  String? mime = lookupMimeType(item["name"]);
  // print(mime);

  if (mime?.startsWith("application/x-subrip") ?? false) {
    return Icon(Icons.subtitles, color: Colors.red);
  }

  if (item["isfolder"] ?? false) {
    return Icon(Icons.folder, color: Colors.yellow);
  }

  if (mime?.startsWith("video") ?? false) {
    return Icon(Icons.play_circle, color: Colors.red);
  }

  if (mime?.startsWith("audio") ?? false) {
    return Icon(Icons.music_note, color: Colors.green);
  }

  if (mime?.startsWith("image") ?? false) {
    return Icon(Icons.image, color: Colors.green);
  }

  if (item["istorrent"] ?? false) {
    return Icon(Icons.downloading, color: Colors.orange);
  }
  if (item["isfile"] ?? false) {
    return Icon(Icons.text_snippet, color: Colors.yellow[200]);
  }

  return Icon(Icons.device_unknown_rounded, color: Colors.yellow[200]);
}
