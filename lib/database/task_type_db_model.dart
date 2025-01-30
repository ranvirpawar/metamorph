// import 'package:hive/hive.dart';
// import 'package:flutter/material.dart';
//
// import '../src/task_type_modal.dart';
//
// part 'task_type_db_model.g.dart';
//
// @HiveType(typeId: 0)
// class TaskTypeDBModel {
//   @HiveField(0)
//   final String id;
//
//   @HiveField(1)
//   final String name;
//   //
//   @HiveField(2)
//   final int colorValue;
//
//   @HiveField(3)
//   final String emoji;
//
//   Color get color => Color(colorValue);
//
//   const TaskTypeDBModel({
//     required this.id,
//     required this.name,
//     required Color color,
//     this.emoji = "📌",
//   }) : colorValue = color.value;
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'colorValue': colorValue,
//     'emoji': emoji,
//   };
//
//   factory TaskTypeDBModel.fromJson(Map<String, dynamic> json) => TaskTypeDBModel(
//     id: json['id'],
//     name: json['name'],
//     color: Color(json['colorValue']),
//     emoji: json['emoji'],
//   );
//
//   factory TaskTypeDBModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return TaskType.fromJson(data);
//   }
// }
