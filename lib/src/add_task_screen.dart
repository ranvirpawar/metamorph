import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:metamorph/src/task_controller.dart';
import 'package:metamorph/src/task_model.dart';
import 'package:metamorph/src/task_type_modal.dart';
import 'package:metamorph/theme/app_colors.dart';

import '../components/color_picker_widget.dart';
import '../components/emoji_picker_widget.dart';

class AddTaskPage extends StatelessWidget {
  final taskController = Get.put(TaskController());
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final selectedDate = DateTime.now().obs;
  final selectedStartTime = DateTime.now().obs;
  final selectedEndTime = DateTime.now().add(const Duration(hours: 1)).obs;
  final selectedType = TaskController().taskTypes[0].obs;
  final isRoutine = false.obs;

  @override
  Widget build(BuildContext context) {
    // Helper method for time picker
    void showTimePickerSheet(BuildContext context, bool isStartTime) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: 200,
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

    // Helper method for date picker
    Future<void> showDatePickerBottomSheet(
        BuildContext context,  selectedDate) async {
      final date = await showModalBottomSheet<DateTime>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  dateOrder: DatePickerDateOrder.ymd,
                  showDayOfWeek: true,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate.value,
                  onDateTimeChanged: (date) => selectedDate.value = date,
                ),
              ),
            ],
          ),
        ),
      );
      if (date != null) {
        selectedDate.value = date;
      }
    }

    // Helper method for adding new task types
    void showAddTaskTypeDialog(BuildContext context) {
      final taskController = Get.find<TaskController>();
      final newTypeController = TextEditingController();
      final selectedColor = Colors.blue.obs;
      final selectedEmoji = "📌".obs;
      final errorText = RxString('');

      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create New Task Type',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: newTypeController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Task type name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Obx(() => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        selectedEmoji.value,
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                    errorText: errorText.value.isEmpty ? null : errorText.value,
                    errorStyle: TextStyle(color: Colors.redAccent),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emoji',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Obx(() => EmojiPickerButton(
                            selectedEmoji: selectedEmoji.value,
                            onEmojiSelected: (emoji) => selectedEmoji.value = emoji,
                          )),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Color',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Obx(() => ColorPickerButton(
                            selectedColor: selectedColor.value,
                            onColorChanged: (color) => selectedColor.value = color as MaterialColor,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        final name = newTypeController.text.trim();
                        if (name.isEmpty) {
                          errorText.value = 'Name cannot be empty';
                          return;
                        }

                        // Check for duplicate names
                        if (taskController.taskTypes.any((type) =>
                        type.name.toLowerCase() == name.toLowerCase())) {
                          errorText.value = 'Task type already exists';
                          return;
                        }

                        // Update TaskType model to include emoji
                        final  newType = TaskType(
                          id: name.toLowerCase().replaceAll(' ', '_'),
                          name: name,
                          color: selectedColor.value,
                          emoji: selectedEmoji.value,
                        );
                        taskController.addTaskType(newType);

                        Get.back();
                        Get.snackbar(
                          'Success',
                          'Task type "$name" added successfully',
                          backgroundColor: Colors.green.withOpacity(0.3),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: EdgeInsets.all(20),
                          borderRadius: 10,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedColor.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
      if (type.id == 'work' || type.id == 'study')
        return; // Prevent deleting default types

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
      );
    }

    String _getTypeEmoji(String typeId) {
      switch (typeId) {
        case 'work':
          return '👔';
        case 'study':
          return '📚';
        default:
          return '📌';
      }
    }

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
                        await showDatePickerBottomSheet(context, selectedDate);
                      },
                      child: Obx(() => Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 12),
                                Text(
                                  DateFormat('EEE, MMM d')
                                      .format(selectedDate.value),
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
                            onTap: () => showTimePickerSheet(context, true),
                            child: Obx(() => Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: Colors.white, size: 20),
                                    SizedBox(width: 12),
                                    Text(
                                      DateFormat('h:mm a')
                                          .format(selectedStartTime.value),
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
                          child: Icon(Icons.arrow_forward,
                              color: Colors.grey[600], size: 20),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => showTimePickerSheet(context, false),
                            child: Obx(() => Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: Colors.white, size: 20),
                                    SizedBox(width: 12),
                                    Text(
                                      DateFormat('h:mm a')
                                          .format(selectedEndTime.value),
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
                          onPressed: () => showAddTaskTypeDialog(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Obx(() => Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: taskController.taskTypes
                          .map(
                            (type) => GestureDetector(
                          onTap: () => selectedType.value = type,
                          onLongPress: () =>
                              _showDeleteTypeDialog(context, type),
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
                              '${type.emoji ?? "📌"} ${type.name ?? " "}',
                              style: TextStyle(
                                color: selectedType.value.id == type.id
                                    ? type.color
                                    : Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                          .toList(),
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
                    Obx(() => CupertinoSwitch(
                        value: isRoutine.value,
                        onChanged: (value) => isRoutine.value = value,
                        activeColor: AppColors.accent)),
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
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
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
