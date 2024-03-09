import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:mile_stone_01/models/student.dart";

class StudentsRepository extends ChangeNotifier {
  final students = [
    Student("Rashid", "Sadeed", 22, "male"),
    Student("Taha", "Kocak", 19, "male"),
    Student("Defne", "eroglu", 19, "female"),
    Student("Bahar", "Ayaz", 22, "female"),
    Student("Talha", "yigit", 22, "male"),
  ];

  final Set<Student> liked = {};

  void like(Student student, bool isLiked) {
    if (isLiked){
      liked.add(student);
    } else{
      liked.remove(student);
    }
    notifyListeners();
  }

  bool isLiked(Student student){
    return liked.contains(student);
  }
}

final studentsProvider = ChangeNotifierProvider((ref){
  return StudentsRepository();
});

