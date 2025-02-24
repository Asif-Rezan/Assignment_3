import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart'; 
part 'task_model.freezed.dart'; 

@freezed
@HiveType(typeId: 0) 
class TaskModel with _$TaskModel {
  const TaskModel._(); 

  const factory TaskModel({
    @HiveField(0) @JsonKey(name: 'id') int id,
    @HiveField(1) @JsonKey(name: 'todo') String todo,
    @HiveField(2) @JsonKey(name: 'completed') bool completed,
    @HiveField(3) @JsonKey(name: 'userId') int userId,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}
