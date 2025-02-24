import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment_2/data/models/task/task_model.dart';
import 'package:assignment_2/repository/task/task_repository.dart';
import 'package:hive/hive.dart';

// Events
abstract class TaskEvent {}

class FetchTasks extends TaskEvent {}

// States
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String error;
  TaskError(this.error);
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  final Box<TaskModel> taskBox;

  TaskBloc({required this.taskRepository, required this.taskBox})
      : super(TaskInitial()) {
    on<FetchTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await taskRepository.getTasks();

        // Save tasks to Hive (local storage)
        if (tasks.isNotEmpty) {
          await taskBox.clear();
          await taskBox.addAll(tasks);
        }

        emit(TaskLoaded(tasks));
      } catch (e) {
        print("Error in TaskBloc: $e");

        // Load from local storage if available
        if (taskBox.isNotEmpty) {
          emit(TaskLoaded(taskBox.values.toList()));
        } else {
          emit(TaskError("No internet & no tasks found offline."));
        }
      }
    });
  }
}
