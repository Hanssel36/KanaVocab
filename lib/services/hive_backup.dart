import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../models/cards.dart';
import '../models/flashcardmodel.dart';
import '../models/tuple2_adapter.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> backupHiveBox(String boxName) async {
  // Request storage permission
  PermissionStatus permissionStatus = await Permission.storage.request();
  if (!permissionStatus.isGranted) {
    // Handle permission denied
    print('Storage permission denied');
    return;
  }

  // Get the box
  Box box = Hive.box(boxName);

  // Convert the box content to a JSON-compatible format
  Map<String, dynamic> jsonCompatibleMap = {};
  box.toMap().forEach((key, value) {
    Map<String, dynamic> innerMap = {};
    (value as Map).forEach((innerKey, innerValue) {
      String innerKeyJson = json.encode(innerKey);
      if (innerValue is List) {
        innerMap[innerKeyJson] = innerValue.map((e) => e.toJson()).toList();
      } else {
        innerMap[innerKeyJson] = innerValue.toJson();
      }
    });
    jsonCompatibleMap[key.toString()] = innerMap;
  });

  // Serialize the JSON-compatible map
  String jsonBackup = json.encode(jsonCompatibleMap);

  // Get the external storage directory
  Directory? externalDir = await getExternalStorageDirectory();

  // Create the backup file
  File backupFile = File('${externalDir!.path}/hive_backup_$boxName.json');

  // Save the backup JSON to the file
  await backupFile.writeAsString(jsonBackup);

  print('Backup saved at ${backupFile.path}');
}

Future<void> restoreHiveBox(String boxName) async {
  // Request storage permission
  PermissionStatus permissionStatus = await Permission.storage.request();
  if (!permissionStatus.isGranted) {
    // Handle permission denied
    print('Storage permission denied');
    return;
  }

  // Get the external storage directory
  Directory? externalDir = await getExternalStorageDirectory();

  // Get the backup file
  File backupFile = File('${externalDir!.path}/hive_backup_$boxName.json');

  // Check if the backup file exists
  if (!await backupFile.exists()) {
    print('Backup file not found');
    return;
  }

  // Read the backup JSON from the file
  String jsonBackup = await backupFile.readAsString();

  // Parse the JSON backup
  Map<String, dynamic> jsonCompatibleMap = json.decode(jsonBackup);

  // Get the box
  Box box = Hive.box(boxName);

  // Clear the current box content
  await box.clear();

  // Update the box with the parsed data
  jsonCompatibleMap.forEach((key, value) {
    Map<dynamic, dynamic> innerMap = {};
    (value as Map<String, dynamic>).forEach((innerKey, innerValue) {
      dynamic decodedInnerKey = json.decode(innerKey);
      if (innerValue is List) {
        if (innerValue.isNotEmpty && innerValue[0] is Map<String, dynamic>) {
          if (innerValue[0].containsKey('title')) {
            innerMap[decodedInnerKey] =
                innerValue.map((e) => Cards.fromJson(e)).toList();
          } else {
            innerMap[decodedInnerKey] =
                innerValue.map((e) => FlashcardModel.fromJson(e)).toList();
          }
        }
      } else {
        innerMap[decodedInnerKey] = Tuple2Adapter.fromJson(innerValue);
      }
    });
    box.put(key, innerMap);
  });

  print('Hive box restored from backup');
}
