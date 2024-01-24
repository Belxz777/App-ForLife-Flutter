import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatdo/dataModels/todo.dart';
import 'package:whatdo/database/todo.db.dart';
import 'package:whatdo/extendWidgets/TodoTile.dart';


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
      final TextEditingController textDescription= TextEditingController();
    final TextEditingController textControl  = TextEditingController();
   void initState (){
    Provider.of<TodoDb>(context, listen: false).readTodos();
    super.initState();
  }
  
void deleteHabitBox(Todo todo){
  showDialog(context: context,
  builder: (context)=>AlertDialog(
    title: Text('Удалить ${todo.name}?'),
    content: Text('Это действие нельзя будет отменить'),
    actions: [
      MaterialButton(onPressed:() {
        context.read<TodoDb>().deleteTodo(todo.id);
        Navigator.pop(context);
      },
      child: const Text('Удалить'),
      ),
      MaterialButton(onPressed:() {
        Navigator.pop(context);
      },
      child: const Text('Отмена'),
      )
    ],
  ),
  );
 } // Список заметок
void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Flex(
          direction: Axis.vertical,
          children: [
            TextField(
        autocorrect: true,
        controller: textControl,
        decoration: InputDecoration(
          hintText: 'Создай новую  полезную привычку',
        ),
      ),
           TextField(
        autocorrect: true,
        controller: textDescription,
        decoration: InputDecoration(
          hintText: 'Описание привычки',
        ),
      ),

          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String name = textControl.text;
          String about = textDescription.text;
           DateTime createdAt= DateTime.now();
            context.read<TodoDb>().addNewTodo(name,about,createdAt);
              Navigator.pop(context);
              textControl.clear();
            },
            child: const Text('Сохранить'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textControl.clear();
            },
            child: const Text('Удалить'),
          )
        ],
      ),
    );
  }
  // Функция для добавления новой заметки


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Пожалуйста работай'),
        elevation: 0,

        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Colors.white,
        child:  const Icon(Icons.add),
        ),
      body: ListView(
      children: [
        _buildHabitList(),  
      ],
    ),
        );
  }
  Widget _buildHabitList() {
  final todoDb = context.watch<TodoDb>();
  List<Todo> currentHabits = todoDb.currentHabits;

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: currentHabits.length,
    itemBuilder: (context, index) {
      final todo = currentHabits[index];
      //bool isCompletedToday = isHabitCompleted(habit.completedDays);
      return TodoTile(
        name:todo.name , 
        description: todo.description,
        createdAt: todo.createdAt,
        onChanged: (value) => (),
  deleteHabit: (context)=> deleteHabitBox(todo),
      );
    }
  );
}

}
