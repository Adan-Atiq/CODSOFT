import 'package:flutter/material.dart';
import '../AppColors.dart';
import '../Sharedpraferences/SharedPreferencesHelper.dart';
import '../model/taskModel.dart';
import 'CreateTaskPage.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Task> tasks = [];
  List<Task> filteredTasks = [];
  TextEditingController searchController = TextEditingController();

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    List<Task> loadedTasks = await SharedPreferencesHelper.loadTasks();
    setState(() {
      tasks = loadedTasks;
      filteredTasks = tasks; // Initially show all tasks
    });
  }

  // Save tasks to SharedPreferences
  Future<void> saveTasks() async {
    await SharedPreferencesHelper.saveTasks(tasks);
  }

  @override
  void initState() {
    super.initState();
    loadTasks(); // Load tasks when the page is first created

    // Add a listener to update the filtered tasks on search
    searchController.addListener(() {
      setState(() {
        filteredTasks = tasks
            .where((task) =>
            task.title.toLowerCase().contains(
                searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  // Toggle task status
  void toggleTaskStatus(int index, String action) {
    setState(() {
      if (action == 'complete' && filteredTasks[index].status == 'Pending') {
        filteredTasks[index].status = 'Completed';
      } else if (action == 'incomplete' &&
          filteredTasks[index].status == 'Pending') {
        filteredTasks[index].status = 'Incomplete';
      }
      saveTasks(); // Save after status change
    });
  }

  // Delete a task
  void deleteTask(int index) {
    setState(() {
      tasks.remove(filteredTasks[index]);
      filteredTasks.removeAt(index);
      saveTasks(); // Save after deletion
    });
  }

  // Edit a task
  Future<void> editTask(int index) async {
    final editedTask = await showDialog<Task>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(
                    text: filteredTasks[index].title),
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  filteredTasks[index].title = value;
                },
              ),
              TextField(
                controller: TextEditingController(
                    text: filteredTasks[index].description),
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  filteredTasks[index].description = value;
                },
              ),
              TextField(
                controller: TextEditingController(
                    text: filteredTasks[index].endDate),
                decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
                onChanged: (value) {
                  filteredTasks[index].endDate = value;
                },
              ),
              DropdownButton<String>(
                value: filteredTasks[index].priority,
                items: ['Low', 'Medium', 'High']
                    .map((priority) =>
                    DropdownMenuItem<String>(
                      value: priority,
                      child: Text(priority),
                    ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    filteredTasks[index].priority = value!;
                  });
                },
              ),
              DropdownButton<String>(
                value: filteredTasks[index].status,
                items: ['Pending', 'Completed', 'Incomplete']
                    .map((status) =>
                    DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    filteredTasks[index].status = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(filteredTasks[index]);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (editedTask != null) {
      setState(() {
        tasks[tasks.indexWhere((task) =>
        task.title == filteredTasks[index].title)] = editedTask;
        saveTasks(); // Save after editing
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyTaskBoard',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];

                  Color leftBorderColor;
                  IconData statusIcon;
                  Color statusTextColor;
                  Color iconColor;
                  Color endDateTextColor;
                  Color buttonColor;

                  // Determine the color scheme based on task status
                  if (task.status == 'Completed') {
                    leftBorderColor = AppColors.completeStatusColor;
                    statusIcon = Icons.check_circle;
                    statusTextColor = AppColors.completeStatusColor;
                    iconColor = AppColors.completeStatusColor;
                    endDateTextColor = AppColors.completeStatusColor;
                    buttonColor = AppColors.completeStatusColor;
                  } else if (task.status == 'Incomplete') {
                    leftBorderColor = AppColors.incompleteStatusColor;
                    statusIcon = Icons.cancel;
                    statusTextColor = AppColors.incompleteStatusColor;
                    iconColor = AppColors.incompleteStatusColor;
                    endDateTextColor = AppColors.incompleteStatusColor;
                    buttonColor = AppColors.incompleteStatusColor;
                  } else {
                    leftBorderColor = AppColors.pendingStatusColor;
                    statusIcon = Icons.pending;
                    statusTextColor = AppColors.pendingStatusColor;
                    iconColor = AppColors.pendingStatusColor;
                    endDateTextColor = AppColors.pendingStatusColor;
                    buttonColor = AppColors.pendingStatusColor;
                  }

                  return Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${task.endDate}',
                                  style: TextStyle(
                                    color: endDateTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Icon(statusIcon, color: statusTextColor, size: 24),
                            SizedBox(height: 4),
                            Text(
                              task.status,
                              style: TextStyle(
                                color: statusTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: leftBorderColor, width: 3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  task.description,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Priority: ${task.priority}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                              Icons.check_circle,
                                              color: task.status == 'Completed'
                                                  ? iconColor
                                                  : Colors.grey),
                                          onPressed: task.status == 'Pending'
                                              ? () =>
                                              toggleTaskStatus(
                                                  index, 'complete')
                                              : null,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              Icons.cancel,
                                              color: task.status == 'Incomplete'
                                                  ? iconColor
                                                  : Colors.grey),
                                          onPressed: task.status == 'Pending'
                                              ? () =>
                                              toggleTaskStatus(
                                                  index, 'incomplete')
                                              : null,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: buttonColor),
                                          onPressed: () => editTask(index),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: buttonColor),
                                          onPressed: () => deleteTask(index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreateTaskPage()),
                );
                if (newTask != null) {
                  setState(() {
                    tasks.add(newTask);
                    filteredTasks = tasks; // Update filtered tasks
                    saveTasks(); // Save after adding new task
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: Text('Create New Task',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
