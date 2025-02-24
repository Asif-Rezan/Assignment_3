import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment_2/data/models/task/task_model.dart';
import 'package:assignment_2/repository/task/task_repository.dart';
import 'package:assignment_2/widgets/task_list_widget.dart';
import 'package:assignment_2/bloc/task_bloc.dart';
import 'package:hive/hive.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<TaskModel>('tasksBox'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error opening local storage: ${snapshot.error}"));
        } else {
          final taskBox = Hive.box<TaskModel>('tasksBox');

          return BlocProvider(
            create: (context) => TaskBloc(
              taskRepository: TaskRepository(),
              taskBox: taskBox,
            )..add(FetchTasks()),
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                title: const Text(
                  'Task Manager',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TaskLoaded) {
                    return state.tasks.isNotEmpty
                        ? TaskList(
                            tasks: state.tasks,
                            onUpdateTask: (_) {},
                          )
                        : const Center(child: Text("No tasks available"));
                  } else if (state is TaskError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          );
        }
      },
    );
  }
}
