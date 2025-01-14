import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:metamorph/src/task_controller.dart';
import 'package:metamorph/src/task_model.dart';
import 'package:metamorph/src/task_type_modal.dart';

class AddTaskPage extends StatelessWidget {
  final taskController = Get.put(TaskController());
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final selectedDate = DateTime
      .now()
      .obs;
  final selectedStartTime = DateTime
      .now()
      .obs;
  final selectedEndTime = DateTime
      .now()
      .add(const Duration(hours: 1))
      .obs;
  final selectedType = TaskController().taskTypes[0].obs;
  final isRoutine = false.obs;

  @override
  Widget build(BuildContext context) {
    // Helper method for time picker
    /*void _showTimePickerSheet(BuildContext context, bool isStartTime) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      isStartTime ? 'Start Time' : 'End Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: isStartTime
                          ? selectedStartTime.value
                          : selectedEndTime.value,
                      onDateTimeChanged: (time) {
                        if (isStartTime) {
                          selectedStartTime.value = time;
                        } else {
                          selectedEndTime.value = time;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
      );
    }

     */
    void _showTimePickerSheet(BuildContext context, bool isStartTime) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple[700]!, Colors.deepPurple[400]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              // Header with title and close button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isStartTime ? 'Start Time' : 'End Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white54,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              // Time Picker
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: isStartTime
                        ? selectedStartTime.value
                        : selectedEndTime.value,
                    onDateTimeChanged: (time) {
                      if (isStartTime) {
                        selectedStartTime.value = time;
                      } else {
                        selectedEndTime.value = time;
                      }
                    },
                  ),
                ),
              ),
              // Action Buttons
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle save action
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

// Helper method for adding new task types
    void _showAddTaskTypeDialog(BuildContext context) {
      final newTypeController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) =>
            Dialog(
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add New Task Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: newTypeController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter task type name',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            // Add new task type logic here
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      );
    }
    void _showDeleteTypeDialog(BuildContext context, TaskType type) {
      if (type.id == 'work' || type.id == 'study') return; // Prevent deleting default types

      Get.dialog(
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Delete "${type.name}" task type?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        taskController.removeTaskType(type.id);
                        Get.back();
                      },
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );}
    String _getTypeEmoji(String typeId) {
      switch (typeId) {
        case 'work':
          return '👔';
        case 'study':
          return '📚';
        default:
          return '📌';
      }}
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Create Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Name Input with Animation
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(bottom: 24),
                child: TextField(
                  controller: titleController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'What\'s on your mind?',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 24,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),

              // Date and Time Section
              Container(
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Picker
                    GestureDetector(
                      onTap: () async {
                        final date = await showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) =>
                              Container(
                                height: 400,
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Select Date',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: selectedDate.value,
                                        minimumDate: DateTime.now(),
                                        maximumDate: DateTime.now().add(
                                            Duration(days: 365)),
                                        onDateTimeChanged: (date) =>
                                        selectedDate.value = date,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        );
                      },
                      child: Obx(() =>
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.white,
                                    size: 20),
                                SizedBox(width: 12),
                                Text(
                                  DateFormat('EEE, MMM d').format(
                                      selectedDate.value),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),

                    Divider(color: Colors.grey[800], height: 24),

                    // Time Range Picker
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showTimePickerSheet(context, true),
                            child: Obx(() =>
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: Colors.white,
                                        size: 20),
                                    SizedBox(width: 12),
                                    Text(
                                      DateFormat('h:mm a').format(
                                          selectedStartTime.value),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.arrow_forward, color: Colors
                              .grey[600], size: 20),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showTimePickerSheet(context, false),
                            child: Obx(() =>
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: Colors.white,
                                        size: 20),
                                    SizedBox(width: 12),
                                    Text(
                                      DateFormat('h:mm a').format(
                                          selectedEndTime.value),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Task Type',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: () => _showAddTaskTypeDialog(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Obx(() => Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: taskController.taskTypes.map((type) =>
                          GestureDetector(
                            onTap: () => selectedType.value = type,
                            onLongPress: () => _showDeleteTypeDialog(context, type),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: selectedType.value.id == type.id
                                    ? type.color.withOpacity(0.3)
                                    : Colors.grey[800],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selectedType.value.id == type.id
                                      ? type.color
                                      : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                '${_getTypeEmoji(type.id)} ${type.name}',
                                style: TextStyle(
                                  color: selectedType.value.id == type.id
                                      ? type.color
                                      : Colors.grey[400],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                      ).toList(),
                    )),
                  ],
                ),
              ),

              // Notes Section
              Container(
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: noteController,
                      maxLines: null,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add your notes here...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),

              // Routine Toggle
              Container(
                margin: EdgeInsets.only(bottom: 32),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add to Daily Routine',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Obx(() =>
                        CupertinoSwitch(
                          value: isRoutine.value,
                          onChanged: (value) => isRoutine.value = value,
                          activeColor: Colors.blue,
                        )),
                  ],
                ),
              ),

              // Save Button
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    final task = Task(
                      id: DateTime
                          .now()
                          .millisecondsSinceEpoch
                          .toString(),
                      title: titleController.text,
                      date: selectedDate.value,
                      startTime: selectedStartTime.value,
                      endTime: selectedEndTime.value,
                      type: selectedType.value,
                      note: noteController.text,
                      isRoutine: isRoutine.value,
                    );
                    taskController.addTask(task);
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Create Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
