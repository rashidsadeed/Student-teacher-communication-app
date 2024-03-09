import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mile_stone_01/pages/StudentsPage.dart';
import 'package:mile_stone_01/pages/TeachersPage.dart';
import 'package:mile_stone_01/pages/messages_page.dart';
import 'package:mile_stone_01/repository/message_repo.dart';
import 'package:mile_stone_01/repository/student_repo.dart';
import 'package:mile_stone_01/repository/teacher_repo.dart';

void main() {
  runApp(const ProviderScope(child: StudentCommunication()));
}

class StudentCommunication extends StatelessWidget {
  const StudentCommunication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Student Communication" ,
      //home: const HomePage(title: "Student Home page"),
      home: HomePage(title: "home"),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    final teachersRepository = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){
                  _accessMessages(context);
                },
                child: Text("${ref.watch(newMessagesProvider)} new messages")),
            TextButton(
                onPressed: (){
                  _accessStudents(context);
                },
                child: Text("${studentsRepository.students.length} Students")),
            TextButton(
                onPressed: (){
                  _accessTeachers(context);
                },
                child: Text("${teachersRepository.teachers.length} Teachers"))

          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text("Student name")
            ),
            ListTile(
              title: const Text("Students"),
              onTap: (){
                _accessStudents(context);
              },
            ),
            ListTile(
              title: const Text("Teachers"),
              onTap: (){
                _accessTeachers(context);
              },
            ),
            ListTile(
              title: const Text("Messages"),
              onTap: (){
                _accessMessages(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _accessStudents(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const StudentsPage();
    },));
  }

  void _accessTeachers(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const TeachersPage();
    },));
  }

  Future<void> _accessMessages (BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const MessagesPage();
    },));
  }


}
