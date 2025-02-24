import 'package:assignment_2/config/app_url.dart';
import 'package:assignment_2/data/models/task/task_model.dart';
import 'package:assignment_2/data/network/network_services_api.dart';
import 'package:assignment_2/utils/network_utils.dart'; 
import 'package:hive/hive.dart';

class TaskRepository {
  final _api = NetworkServicesApi();
  final String _boxName = 'tasksBox';

  Future<List<TaskModel>> getTasks() async {
    final box = await Hive.openBox<TaskModel>(_boxName);

    if (await NetworkUtils.isConnected()) {
      try {
        final response = await _api.getTask(AppUrl.tasks);
        print('API Response: $response');

        if (response != null && response is Map && response.containsKey('todos')) {
          var taskList = response['todos'] as List;

          if (taskList.isNotEmpty) {
            await box.clear(); // Clear old tasks before saving new ones

            // Directly convert and store tasks in Hive using their ID as key
            for (var task in taskList) {
              var taskModel = TaskModel.fromJson(task);
              await box.put(taskModel.id, taskModel);
            }
          }

          return box.values.toList(); // Return updated tasks from Hive
        } else {
          throw Exception('Unexpected response format');
        }
      } catch (e) {
        print('Error fetching tasks from API: $e');
        return _loadTasksFromLocal(box);
      }
    } else {
      print('No internet connection, loading tasks from local storage.');
      return _loadTasksFromLocal(box);
    }
  }

  List<TaskModel> _loadTasksFromLocal(Box<TaskModel> box) {
    if (box.isNotEmpty) {
      print('Loaded tasks from Hive: ${box.values.toList()}');
      return box.values.toList();
    } else {
      throw Exception("No tasks available offline.");
    }
  }
}
