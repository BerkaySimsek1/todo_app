// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  final dynamic task;
  final dynamic description;
  bool deneme;

  Task({required this.task, required this.description, required this.deneme});

  dynamic getDataMap() {
    return {
      "task": task,
      "description": description,
      "deneme": deneme,
    };
  }
}
