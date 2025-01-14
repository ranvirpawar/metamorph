import 'package:get/get.dart';
import 'package:metamorph/src/task_controller.dart';
import 'package:metamorph/src/task_type_modal.dart';



class Task {
  final String id;
  final String title;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final TaskType type;
  final String note;
  final bool isRoutine;
  final String? parentRoutineId; // Added to track related routine tasks
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.note,
    this.isRoutine = false,
    this.parentRoutineId,
    this.isCompleted = false,
  });
}

