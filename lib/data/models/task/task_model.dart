import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @Default(0) @JsonKey(name: 'id') int id,             
    @Default('') @JsonKey(name: 'todo') String todo,
    @Default(false) @JsonKey(name: 'completed') bool completed, 
    @Default(0) @JsonKey(name: 'userId') int userId,        
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}
