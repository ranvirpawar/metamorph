// import 'package:hive/hive.dart';
//
// import '../database/task_db_model.dart';
// import '../database/task_type_db_model.dart';
// import '../src/task_model.dart';
// import '../src/task_type_modal.dart';
//
// // database_service.dart
// class DatabaseService {
//   static final DatabaseService _instance = DatabaseService._internal();
//   factory DatabaseService() => _instance;
//   DatabaseService._internal();
//
//   late Box<Task> _taskBox;
//   late Box<TaskType> _taskTypeBox;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> init() async {
//     await Hive.initFlutter();
//     Hive.registerAdapter(TaskTypeAdapter());
//     Hive.registerAdapter(TaskAdapter());
//
//     _taskBox = await Hive.openBox<Task>('tasks');
//     _taskTypeBox = await Hive.openBox<TaskType>('taskTypes');
//   }
//
//   // Task Type Operations
//   Future<void> saveTaskType(TaskType taskType) async {
//     // Save to Hive
//     await _taskTypeBox.put(taskType.id, taskType);
//
//     // Save to Firebase
//     await _firestore
//         .collection('taskTypes')
//         .doc(taskType.id)
//         .set(taskType.toJson());
//   }
//
//   Future<List<TaskType>> getAllTaskTypes() async {
//     // First try to get from Hive
//     final localTypes = _taskTypeBox.values.toList();
//
//     if (localTypes.isEmpty) {
//       // If local is empty, fetch from Firebase
//       final snapshot = await _firestore.collection('taskTypes').get();
//       final types = snapshot.docs.map((doc) => TaskType.fromFirestore(doc)).toList();
//
//       // Save to local
//       await Future.wait(
//           types.map((type) => _taskTypeBox.put(type.id, type))
//       );
//
//       return types;
//     }
//
//     return localTypes;
//   }
//
//   // Task Operations
//   Future<void> saveTask(Task task) async {
//     // Save to Hive
//     await _taskBox.put(task.id, task);
//
//     // Save to Firebase
//     await _firestore
//         .collection('tasks')
//         .doc(task.id)
//         .set(task.toJson());
//   }
//
//   Future<void> saveBatchTasks(List<Task> tasks) async {
//     // Batch write to Hive
//     final taskMap = {for (var task in tasks) task.id: task};
//     await _taskBox.putAll(taskMap);
//
//     // Batch write to Firebase
//     final batch = _firestore.batch();
//     for (var task in tasks) {
//       batch.set(
//           _firestore.collection('tasks').doc(task.id),
//           task.toJson()
//       );
//     }
//     await batch.commit();
//   }
//
//   Future<List<Task>> getTasksForDate(DateTime date) async {
//     final localTasks = _taskBox.values.where((task) =>
//     task.date.year == date.year &&
//         task.date.month == date.month &&
//         task.date.day == date.day
//     ).toList();
//
//     if (localTasks.isEmpty) {
//       // Fetch from Firebase if local is empty
//       final startOfDay = DateTime(date.year, date.month, date.day);
//       final endOfDay = startOfDay.add(Duration(days: 1));
//
//       final snapshot = await _firestore
//           .collection('tasks')
//           .where('date', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
//           .where('date', isLessThan: endOfDay.toIso8601String())
//           .get();
//
//       final tasks = snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
//
//       // Save to local
//       await Future.wait(
//           tasks.map((task) => _taskBox.put(task.id, task))
//       );
//
//       return tasks;
//     }
//
//     return localTasks;
//   }
//
//   Future<void> deleteTask(String taskId) async {
//     // Delete from Hive
//     await _taskBox.delete(taskId);
//
//     // Delete from Firebase
//     await _firestore.collection('tasks').doc(taskId).delete();
//   }
//
//   Future<void> updateTask(Task task) async {
//     // Update in Hive
//     await _taskBox.put(task.id, task);
//
//     // Update in Firebase
//     await _firestore
//         .collection('tasks')
//         .doc(task.id)
//         .update(task.toJson());
//   }
//
//   Future<void> syncWithFirebase() async {
//     // Get all tasks from Firebase
//     final snapshot = await _firestore.collection('tasks').get();
//     final firebaseTasks = snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
//
//     // Update local storage
//     await _taskBox.clear();
//     await saveBatchTasks(firebaseTasks);
//   }
//
// }
//
