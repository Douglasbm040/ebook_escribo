import 'package:ebook_escribo/modules/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/app_module.dart';
import 'modules/external/database/database_sqlite_datasource.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await DatabaseSqliteDatasource.getInstance();
  runApp(
      ModularApp(module: AppModule(() => database), child: const AppWidget()));
}
