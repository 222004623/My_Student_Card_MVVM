import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/student_viewmodel.dart';

class StudentView extends StatelessWidget
{
  const StudentView({super.key});

  @override
  Widget build(BuildContext context)
  {
    final viewModel = context.watch<StudentViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Student Card - MVVM"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInfoCard(viewModel, context),
            const SizedBox(height: 30),

            _buildSubjectIndicator(),
            const SizedBox(height: 20),

            _buildChangeButton(context),
            const SizedBox(height: 20),

            _buildSubjectList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(StudentViewModel viewModel, BuildContext context)
  {
    return Container
    (
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        children: [
          Text("Student Name: ${viewModel.studentName}", style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Grade:", style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text("${viewModel.grade}%", style: const TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),

              // Decrease button (uses read() because button doesn't need to rebuild)
              IconButton(
                onPressed: () {
                  context.read<StudentViewModel>().decreaseGrade(1);
                },
                icon: const Icon(Icons.remove_circle_outline),
                tooltip: 'Decrease grade',
              ),

              // Increase button
              IconButton(
                onPressed: () {
                  context.read<StudentViewModel>().increaseGrade(1);
                },
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Increase grade',
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text("Favorite Subject: ${viewModel.currentSubject}", style: const TextStyle(fontSize: 20, color: Colors.green),),
        ],
      ),
    );
  }

  Widget _buildSubjectIndicator()
  {
    return Consumer<StudentViewModel>(
      builder: (context, viewModel, child) {
        return Container
        (
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text
          (
            "Subject ${viewModel.currentIndex + 1} of ${viewModel.subjects.length}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget _buildChangeButton(BuildContext context)
  {
    return SizedBox
    (
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<StudentViewModel>().changeSubject();
        },
        
        child: const Text("Change Subject"),
      ),
    );
  }

  Widget _buildSubjectList()
  {
    
    return Consumer<StudentViewModel>
    (
      builder: (context, value, child)
      {
        return Column
        (
          children: 
          [
            const Text
            (
              "Available Subjects:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap
            (
              spacing: 8,
              runSpacing: 8,
              children: value.subjects.map((subject)
              {
                final isCurrent = subject == value.currentSubject;
                return Container
                (
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration
                  (
                    color: isCurrent ? Colors.green : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text
                  (
                    subject,
                    style: TextStyle
                    (
                      color: isCurrent ? Colors.white : Colors.black,
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }
            ).toList(),
            ),
          ],
        );
      },
    );
  }
}