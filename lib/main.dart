import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/db/hive_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await HiveManager.init();

  await Hive.openBox('trending_movies');
  await Hive.openBox('now_playing_movies');

  runApp(MyApp());
}
