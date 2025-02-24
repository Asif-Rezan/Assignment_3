import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:assignment_2/config/routes/routes.dart';
import 'package:assignment_2/config/routes/routes_name.dart';
import 'package:assignment_2/data/models/task/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasksBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
