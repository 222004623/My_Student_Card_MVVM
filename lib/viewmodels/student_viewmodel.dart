import 'package:flutter/foundation.dart';
import '../models/student_model.dart';

class StudentViewModel extends ChangeNotifier 
{

  StudentModel _student = StudentModel
  (
    name: "Mpho",
    currentSubject: "TPG316C",
    subjects: ["TPG316C", "SOD316C", "CMN316C", "ITS316C"],
    currentIndex: 0,
    grade: 75,
  );

  String get studentName => _student.name;
  String get currentSubject => _student.currentSubject;
  List<String> get subjects => _student.subjects;
  int get currentIndex => _student.currentIndex;
  int get grade => _student.grade;

  void changeSubject()
  {
    int newIndex = (_student.currentIndex + 1) % _student.subjects.length;
    String newSubject = _student.subjects[newIndex];

    _student = _student.copyWith(
      name: _student.name,
      currentSubject: newSubject,
      subjects: _student.subjects,
      currentIndex: newIndex,
      grade: _student.grade,
    );
    notifyListeners();
  }

  void increaseGrade([int amount = 1]) {
    final int newGrade = (_student.grade + amount).clamp(0, 100);
    _student = _student.copyWith(grade: newGrade);
    notifyListeners();
  }

  void decreaseGrade([int amount = 1]) {
    final int newGrade = (_student.grade - amount).clamp(0, 100);
    _student = _student.copyWith(grade: newGrade);
    notifyListeners();
  }

  void setGrade(int newGrade) {
    final int clamped = newGrade.clamp(0, 100);
    _student = _student.copyWith(grade: clamped);
    notifyListeners();
  }
}