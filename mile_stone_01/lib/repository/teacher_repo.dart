import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:mile_stone_01/models/teacher.dart";
import 'package:mile_stone_01/services/data_services.dart';

class TeachersRepository extends ChangeNotifier{
  List<Teacher> teachers = [
    Teacher("Ibrahim", "Aba",28, "male"),
    Teacher("Emine deniz", "tekin",34, "female"),
    Teacher("Hasan", "erbay",40, "male"),
    Teacher("Mariana", "Ruski",50, "female"),
    Teacher("Cagri", "Kaygisiz",41, "male"),
  ];

  final DataService dataService;
  TeachersRepository(this.dataService);

  Future<void> download() async{
    Teacher teacher = await dataService.teacherDownload();

    teachers.add(teacher);
    notifyListeners();
  }

  Future<List<Teacher>> bringAll() async {
    teachers = await dataService.bringTeachers();
    return teachers;
  }
}

final teachersProvider = ChangeNotifierProvider((ref) {
  return TeachersRepository(ref.watch(dataServiceProvider));
});

final teacherListProvider = FutureProvider((ref){
  return ref.watch(teachersProvider).bringAll();
});