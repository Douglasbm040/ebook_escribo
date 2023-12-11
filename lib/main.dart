import 'dart:io';

import 'package:ebook_escribo/modules/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/app_module.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

import 'modules/external/database/database_sqlite_datasource.dart';




main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;
  final database = await DatabaseSqliteDatasource.getInstance();
  runApp(ModularApp(module: AppModule(()=>database), child: AppWidget()));
}
















