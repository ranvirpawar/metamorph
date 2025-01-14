import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:metamorph/src/add_task_screen.dart';
import 'package:metamorph/src/task_controller.dart';
import 'package:metamorph/src/task_model.dart';

class TaskListPage extends StatelessWidget {
  final taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi There!'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Horizontal Calendar
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 30,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                return Obx(() => GestureDetector(
                  onTap: () => taskController.selectedDate.value = date,
                  child: Container(
                    width: 60,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: taskController.selectedDate.value.day == date.day
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEE').format(date),
                          style: TextStyle(
                            color: taskController.selectedDate.value.day == date.day
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: taskController.selectedDate.value.day == date.day
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
              },
            ),
          ),

          // Task List
          Expanded(
            child: Obx(() {
              final tasks = taskController.getTasksForDate(taskController.selectedDate.value);
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final isCurrentTask = DateTime.now().isAfter(task.startTime) &&
                      DateTime.now().isBefore(task.endTime);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: isCurrentTask ? Colors.blue.withOpacity(0.05) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          childrenPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: task.isCompleted ? Colors.green : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: InkWell(
                              onTap: () => taskController.toggleTaskCompletion(task.id),
                              child: task.isCompleted
                                  ? Icon(Icons.check, size: 16, color: Colors.green)
                                  : null,
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        decoration: task.isCompleted
                                            ? TextDecoration.lineThrough
                                            : null,
                                        color: task.isCompleted
                                            ? Colors.grey
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // To do - Add hours
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '${DateFormat('h:mm a').format(task.startTime)} - ${DateFormat('h:mm a').format(task.endTime)}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: task.type.color.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            '${task.type.emoji} ${task.type.name}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: task.type.color,
                                            ),
                                          ),
                                        ),



                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) => Container(
                                      padding: EdgeInsets.symmetric(vertical: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.edit, color: Colors.blue),
                                            title: Text('Edit Task'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              // Navigate to edit task
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.delete, color: Colors.red),
                                            title: Text('Delete Task'),
                                            onTap: () {
                                              // Add delete functionality
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.grey.shade50,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (task.note.isNotEmpty) ...[
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.note,
                                                size: 16,
                                                color: Colors.grey.shade600,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Notes',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            task.note,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade800,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                  if (task.isRoutine)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.repeat,
                                            size: 16,
                                            color: Colors.blue.shade700,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Daily Routine Task',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTaskPage()),
        child: Icon(Icons.run_circle),
      ),

    );

  }
}