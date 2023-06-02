import 'package:first_project/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Learn DART', 'assets/images/dart.png', 5),
    Task('Biking', 'assets/images/biking.jpg', 2),
    Task('Meditation', 'assets/images/-Meditation.jpeg', 1),
    Task('Reading', 'assets/images/reading.jpg', 3),
    Task('Playing', 'assets/images/playing.jpg', 4),
  ];

  void newTask(String name, String image, int difficulty){
    taskList.add(Task(name, image, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
