import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          child: Text('save file'),
          onPressed: () => getPermission(),
        ),
      ),
    );
  }

  getPermission() async {
    var status = await Permission.storage.status;
    await Permission.storage.request();
    if (status.isGranted) {
      await saveFile();
    } else {
      await getPermission();
    }
  }

  saveFile() async {
    Directory? appDocDir = await getExternalStorageDirectory();
    String dirPath = appDocDir!.path.split('Android')[0] + 'appName';
    Directory(dirPath).createSync();
    String filePath = dirPath + '/newfile.csv';

    File file = File(filePath);
    print('create file');
    if (!await file.exists()) {
      await file.create();
    } else {
      await file.delete();
      await file.create();
    }
    print('created file');

    // write to the file
  }
}
