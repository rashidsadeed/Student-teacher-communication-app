import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:mile_stone_01/models/teacher.dart';
import "package:mile_stone_01/services/data_services.dart";

class TeacherForm extends ConsumerStatefulWidget {
  const TeacherForm({super.key});

  @override
  _TeacherFormState createState() => _TeacherFormState();
}

class _TeacherFormState extends ConsumerState<TeacherForm> {
  final Map<String, dynamic> added = {};
  final _formKey = GlobalKey<FormState>();

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Teahcer")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (value){
                    if (value?.isNotEmpty != true){
                      return "You have to insert a name";
                    }
                  },
                  onSaved: (newValue){
                    added["name"] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Surame"),
                  ),
                  validator: (value){
                    if (value?.isNotEmpty != true){
                      return "You have to insert a surname";
                    }
                  },
                  onSaved: (newValue){
                    added["surname"] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Age"),
                  ),
                  validator: (value){
                    if (value == null || value.isNotEmpty != true){
                      return "Your age should consist of digits";
                    }
                    },
                  keyboardType: TextInputType.number,
                  onSaved: (newValue){
                    added["age"] = int.parse(newValue!);
                  },
                ),
                DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(
                          child: Text("Male"),
                        value: "Male",
                      ),
                      DropdownMenuItem(
                          child: Text("Female"),
                          value: "Female",
                      )
                    ],
                    value: added["gender"],
                    onChanged: (value){
                      setState(() {
                        added["gender"] = value;
                      });
                    },
                  validator: (value){
                      if (value == null){
                        return "please select a gender";
                      }
                  },
                ),
                isSaving ? const Center(child: CircularProgressIndicator()) : ElevatedButton(
                    onPressed:(){
                      final formState = _formKey.currentState;
                      if (formState == null) return;
                      if (formState.validate() == true) {
                        formState.save();
                        print("added");
                      }
                      saveTeacher();
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> saveTeacher() async {
    bool done = false;

    while(!done){
    try {
      setState(() {
        isSaving = true;
      });
      await actuallySave();
      done = true;
      Navigator.of(context).pop(true);
    } catch (e) {
      final snackBar = ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      await snackBar.closed;
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  }
  int  i =0;

  Future<void> actuallySave() async {
    try{
      await ref.read(dataServiceProvider).addTeacher(Teacher.fromMap(added));
    } catch(e) {
      throw "Teacher not added because of $e";
    }
  }
}



