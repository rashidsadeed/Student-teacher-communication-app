import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mile_stone_01/models/teacher.dart';
import 'package:http/http.dart' as http;


class DataService{

  final String baseURL ="https://65e454333070132b3b248df1.mockapi.io/";

  Future<Teacher> teacherDownload() async {
    final response = await http.get(Uri.parse("$baseURL/teacehr/1"));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load teacher data ${response.statusCode}');
    }

  }

  Future<void> addTeacher(Teacher teacher) async {
       final response = await http.post(
        Uri.parse('$baseURL/teacehr'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(teacher.toMap())
       );
       if (response.statusCode == 201) {
         return;
       } else {
         throw Exception('Failed to add teacher data ${response.statusCode}');
       }
  }

  Future<List<Teacher>> bringTeachers() async {
    final response = await http.get(Uri.parse("$baseURL/teacehr"));

    if (response.statusCode == 200) {
      final l = jsonDecode(response.body);
      return l.map<Teacher>((e)=> Teacher.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load teacher data ${response.statusCode}');
    }

  }

}

final dataServiceProvider = Provider((ref) {
  return DataService();
});

