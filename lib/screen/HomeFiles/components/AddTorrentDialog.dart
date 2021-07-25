import 'package:flutter/material.dart';
import 'package:seedr/provider/SeedrController.dart';
import "package:provider/provider.dart";

// ignore: non_constant_identifier_names
Future ShowTorrentDialog(BuildContext context) async {
  var _controller = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      SeedrController _seedrController = context.read<SeedrController>();
      // return object of type Dialog
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Center(
          child: Text(
            "Upload Torrent URL or Magnet Link",
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'magnet:?xt=urn:btih:',
                  hintStyle: TextStyle(color: Colors.grey),
                  errorText: null,
                  labelStyle: TextStyle(color: Colors.blueAccent),
                ),
                autofocus: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  // usually buttons at the bottom of the dialog
                  IconButton(
                    icon: Icon(
                      Icons.upload_file,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _seedrController.showToast("Coming soon !!");
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.green),
                    child: Text("Add"),
                    onPressed: () async {
                      var _magnet = _controller.text.toString().trim();

                      if (RegExp(r"^magnet:\?xt=").hasMatch(_magnet)) {
                        _seedrController.addTorrent(_magnet);
                        // seedrcontroller.addTorrent(magnet)

                        Navigator.of(context).pop();
                      }

                      // _textvalue.replaceAll(
                      //     new RegExp(r'^http://'), 'https://');

                      // if (!RegExp(r"^https").hasMatch(_textvalue)) {
                      //   _textvalue = "https://" + _textvalue;
                      // }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
