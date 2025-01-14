import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:metamorph/src/task_model.dart';
import 'package:get/get.dart';
import 'package:metamorph/src/task_type_modal.dart';


class TaskController extends GetxController {
  // Observable lists and values
  final tasks = <Task>[].obs;
  final selectedDate = DateTime.now().obs;
  final taskTypes = <TaskType>[
    TaskType(
      id: 'work',
      name: 'Work',
      color: Colors.blue,
    ),
    TaskType(
      id: 'study',
      name: 'Study',
      color: Colors.purple,
    ),
  ].obs;

  // Method to add new task type
  void addTaskType(String name, Color color) {
    final id = name.toLowerCase().replaceAll(' ', '_');
    if (!taskTypes.any((type) => type.id == id)) {
      taskTypes.add(TaskType(
        id: id,
        name: name,
        color: color,
      ));
    }
  }

  // Method to remove task type
  void removeTaskType(String id) {
    taskTypes.removeWhere((type) => type.id == id);
  }

  // Enhanced addTask method with better routine handling
  void addTask(Task task) {
    tasks.add(task);

    if (task.isRoutine) {
      // Add tasks for the next 30 days
      final now = DateTime.now();
      final endDate = DateTime(now.year, now.month + 1, now.day);

      var currentDate = task.date.add(const Duration(days: 1));

      while (currentDate.isBefore(endDate)) {
        final routineTask = Task(
          id: '${task.id}_${currentDate.millisecondsSinceEpoch}',
          title: task.title,
          date: currentDate,
          startTime: DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            task.startTime.hour,
            task.startTime.minute,
          ),
          endTime: DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            task.endTime.hour,
            task.endTime.minute,
          ),
          type: task.type,
          note: task.note,
          isRoutine: true,
          parentRoutineId: task.id, // Added to track related routine tasks
        );

        tasks.add(routineTask);
        currentDate = currentDate.add(const Duration(days: 1));
      }
    }

    _sortTasks();
  }

  // Enhanced updateTask method to handle routine tasks
  void updateTask(String id, Task updatedTask) {
    final index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final oldTask = tasks[index];
      tasks[index] = updatedTask;

      // If it's a routine task, update all related future tasks
      if (oldTask.isRoutine && updatedTask.isRoutine) {
        final relatedTasks = tasks.where(
                (task) => task.parentRoutineId == oldTask.id &&
                task.date.isAfter(updatedTask.date)
        );

        for (var task in relatedTasks) {
          final taskDate = task.date;
          tasks[tasks.indexOf(task)] = Task(
            id: task.id,
            title: updatedTask.title,
            date: taskDate,
            startTime: DateTime(
              taskDate.year,
              taskDate.month,
              taskDate.day,
              updatedTask.startTime.hour,
              updatedTask.startTime.minute,
            ),
            endTime: DateTime(
              taskDate.year,
              taskDate.month,
              taskDate.day,
              updatedTask.endTime.hour,
              updatedTask.endTime.minute,
            ),
            type: updatedTask.type,
            note: updatedTask.note,
            isRoutine: true,
            parentRoutineId: oldTask.id,
          );
        }
      }

      _sortTasks();
      tasks.refresh();
    }
  }

  // Enhanced delete task method to handle routine tasks
  void deleteTask(String id) {
    final task = tasks.firstWhere((task) => task.id == id);

    // If it's a routine task, optionally delete all future occurrences
    if (task.isRoutine) {
      final shouldDeleteAll = true; // You can make this configurable via UI

      if (shouldDeleteAll) {
        tasks.removeWhere((t) =>
        t.id == id || (t.parentRoutineId == task.id && t.date.isAfter(task.date))
        );
      } else {
        tasks.removeWhere((t) => t.id == id);
      }
    } else {
      tasks.removeWhere((t) => t.id == id);
    }

    tasks.refresh();
  }

  void toggleTaskCompletion(String id) {
    final index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      tasks.refresh();
    }
  }

  List<Task> getTasksForDate(DateTime date) {
    return tasks.where((task) =>
    task.date.year == date.year &&
        task.date.month == date.month &&
        task.date.day == date.day
    ).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  // Helper method to sort tasks
  void _sortTasks() {
    tasks.sort((a, b) {
      final dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) return dateComparison;
      return a.startTime.compareTo(b.startTime);
    });
  }

  // Get task statistics
  Map<String, dynamic> getTaskStats() {
    final now = DateTime.now();
    final thisMonth = tasks.where((task) =>
    task.date.year == now.year && task.date.month == now.month
    );

    return {
      'total': tasks.length,
      'completed': tasks.where((task) => task.isCompleted).length,
      'routine': tasks.where((task) => task.isRoutine).length,
      'thisMonth': thisMonth.length,
      'completedThisMonth': thisMonth.where((task) => task.isCompleted).length,
      'typeDistribution': _getTaskTypeDistribution(),
    };
  }

  // Helper method to get task distribution by type
  Map<String, int> _getTaskTypeDistribution() {
    final distribution = <String, int>{};
    for (var type in taskTypes) {
      distribution[type.name] = tasks.where((task) => task.type == type).length;
    }
    return distribution;
  }

  // to get task name
  String getTypeEmoji(String typeId) {
    switch (typeId) {
      case 'work':
        return '👔';
      case 'study':
        return '📚';
      default:
        return '📌';
    }
  }
}