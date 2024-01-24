import 'package:isar/isar.dart';


part 'todo.g.dart';

@collection
@Name('Todos')
class Todo{
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  String? name;

 String? description;

 DateTime? createdAt;

}