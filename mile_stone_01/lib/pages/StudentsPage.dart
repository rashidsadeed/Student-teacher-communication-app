import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mile_stone_01/repository/student_repo.dart';
import "package:mile_stone_01/models/student.dart";

class StudentsPage extends ConsumerWidget{
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final studentsRepository = ref.watch(studentsProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Students")
      ),
      body: Column(
        children: [
           PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                child: Text(
                    "${studentsRepository.students.length} stundets"
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => StudentLine(
                    studentsRepository.students[index],
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: studentsRepository.students.length,
              )
          ),
        ],
      ),
    );
  }
}

class StudentLine extends ConsumerWidget {
  final Student student;
  const StudentLine(this.student, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLiked = ref.watch(studentsProvider).isLiked(student);
    return ListTile(
      title: Text("${student.name} ${student.surname}"),
      leading: IntrinsicWidth(child: Center(child: Text(student.gender == "male" ? "👨‍🦱" : "👩‍🦰"))),
      trailing: IconButton(
          onPressed: (){
            ref.read(studentsProvider).like(student, !isLiked);
          },
          icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}