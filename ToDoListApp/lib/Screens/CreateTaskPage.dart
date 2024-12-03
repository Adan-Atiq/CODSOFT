import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import '../AppColors.dart';
import '../model/taskModel.dart'; // Assuming AppColors is already defined

class CreateTaskPage extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  String selectedPriority = 'Low'; // Default priority

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now(); // Get today's date
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate, // Disable dates before today
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      // Format the picked date to "dd-MM-yyyy" format
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      endDateController.text = formattedDate; // Set the selected date in the TextField
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyTaskBoard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text('Add Task',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
            ),
            SizedBox(height: 20),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Task Description',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context), // Show the calendar when the field is tapped
              child: AbsorbPointer( // Prevent the keyboard from showing
                child: TextField(
                  controller: endDateController,
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today, color: AppColors.primaryColor), // Calendar icon added
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedPriority,
              style: TextStyle(color: Colors.white), // Set text color to white
              dropdownColor: AppColors.primaryColor, // Set dropdown background color
              items: ['Low', 'Medium', 'High']
                  .map((priority) => DropdownMenuItem<String>(
                value: priority,
                child: Text(
                  priority,
                  style: TextStyle(color: Colors.white), // Text color for items
                ),
              ))
                  .toList(),
              onChanged: (value) {
                selectedPriority = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String taskTitle = taskController.text;
                String taskDescription = descriptionController.text;
                String endDate = endDateController.text;

                if (taskTitle.isNotEmpty && taskDescription.isNotEmpty && endDate.isNotEmpty) {
                  Task newTask = Task(
                    title: taskTitle,
                    description: taskDescription,
                    status: 'Pending',
                    endDate: endDate,
                    priority: selectedPriority,
                  );
                  Navigator.pop(context, newTask);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill out all fields')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              child: Text('Save Task', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
