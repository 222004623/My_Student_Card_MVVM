class StudentModel 
{
  final String name;
  final String currentSubject;
  final List<String> subjects;
  final int currentIndex;
  final int grade;

  StudentModel({
    required this.name,
    required this.currentSubject,
    required this.subjects,
    required this.currentIndex,
    required this.grade,
  });

  StudentModel copyWith({
    String? name,
    String? currentSubject,
    List<String>? subjects,
    int? currentIndex,
    int? grade,
  }) {
    return StudentModel(
      name: name ?? this.name,
      currentSubject: currentSubject ?? this.currentSubject,
      subjects: subjects ?? this.subjects,
      currentIndex: currentIndex ?? this.currentIndex,
      grade: grade ?? this.grade,
    );
  }
}