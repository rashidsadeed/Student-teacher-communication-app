import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mile_stone_01/pages/teacher/teacher_form.dart';
import 'package:mile_stone_01/repository/teacher_repo.dart';
import "package:mile_stone_01/models/teacher.dart";



class TeachersPage extends ConsumerWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersRepository = ref.watch(teachersProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Teachers")
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Stack(
              children:[ Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 32.0),
                  child: Text(
                      "${teachersRepository.teachers.length} Teachers"
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: teacherDownloadButton()
              ),
              ]
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(teacherListProvider);
                },
                child: ref.watch(teacherListProvider).when(
                    data: (data) => ListView.separated(
                          itemBuilder: (context, index) => TeacherLine(
                            data[index],
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data.length,
                      ),
                    error: (error, stackTrace){
                      return const SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Text("Error"),
                      );
                    },
                    loading: (){
                      return const Center(child: CircularProgressIndicator());
                    }),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.of(context).push<bool>(MaterialPageRoute(
              builder: (context){
                return const TeacherForm();
              }));
          if (created == true){
            print("update teacehrs list");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class teacherDownloadButton extends StatefulWidget {
  const teacherDownloadButton({
    super.key,
  });

  @override
  State<teacherDownloadButton> createState() => _teacherDownloadButtonState();
}

class _teacherDownloadButtonState extends State<teacherDownloadButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return isLoading ? const CircularProgressIndicator() : IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              // TODO loading
              //TODO error
              try{
                setState(() {
                  isLoading = true;
                });
                await ref.read(teachersProvider).download();
              } catch (e){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                );
              }finally{

                setState(() {
                  isLoading = false;
                });
              }
            }
        );
      }

    );
  }
}

class TeacherLine extends StatelessWidget{
  final Teacher teacher;
  const TeacherLine(this.teacher, {super.key,});

  @override
  Widget build(BuildContext context) {
      return ListTile(
      title: Text("${teacher.name} ${teacher.surname}"),
      leading: IntrinsicWidth(child: Center(child: Text(teacher.gender == "male" ? "👨‍🦱" : "👩‍🦰"))),
      );
  }
}
