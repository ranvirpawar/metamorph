import 'dart:ui';

class TaskType {
  final String id;
  final String name;
  final Color color;
  final String emoji;

  const TaskType({
    required this.id,
    required this.name,
    required this.color,  this.emoji = "📌",
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskType &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

