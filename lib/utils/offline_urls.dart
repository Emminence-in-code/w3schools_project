import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Directory> getMainDirectory() async {
  await getPermissons();
  final dir = await getExternalStorageDirectory();
  List<FileSystemEntity> allFolders = dir!.listSync();
  for (var folder in allFolders) {
    if (folder is Directory && folder.path.contains('W3Schools-main')) {
      return folder;
    }
  }
  return Directory('');
}

Future<void> getPermissons() async {
  try {
    final bool isGranted = await Permission.storage.isGranted;

    if (isGranted) {
      print('Storage Permission is granted');
    }
    if (await Permission.storage.isDenied) {
      Permission.storage.request();
    }
    if (await Permission.storage.isPermanentlyDenied) {
      print('You must grant permission to use offline mode');
      openAppSettings();
    }
  } catch (e) {}
}

String getPath(Directory dir) {
  final itemsInDir = dir.listSync();
  for (var item in itemsInDir) {
    if (item is File && item.path.contains('index')) {
      return item.path;
    }
  }
  return '';
}

