import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatdo/dataModels/todo.dart';
class TodoDb extends ChangeNotifier{
  // Future является ключевым классом для написания асинхронного кода https://metanit.com/dart/tutorial/7.2.php?ysclid=lr7i4h6lye958039997
  //определяем статическую переменную с отложенной инициализацией Isar
  // с помощью нее мы сможем управлять , взаимодействовать с базой данн��х
static late Isar isar;
// функция инициализации
static Future <void> initialize() async {
//иницилизируем базу данных , а именно наши модели привычки и настройки прилоджения 
final dir = await getApplicationDocumentsDirectory();
isar = await Isar.open(
  [TodoSchema], 
  directory: dir.path,
  );
}
final List<Todo> currentHabits = [];
  Future<void> addNewTodo(  String name, String description, DateTime createdDate) async {
    await isar.writeTxn(() async {
      final todo = Todo()
        ..name = name
        ..description = description
        ..createdAt = createdDate;
      await isar.todos.put(todo);
    });
    readTodos();
  }


   Future<void> readTodos() async {  
   List<Todo> fetchedHabits = await isar.todos.where().findAll();
  currentHabits.clear();
  currentHabits.addAll(fetchedHabits);
  notifyListeners();
  }
  Future<void> deleteTodo(int id) async {

    await isar.writeTxn(() async {
      final success = await isar.todos.delete(id);
      debugPrint(' Todo deleted: $success');
    });
  }

}
//