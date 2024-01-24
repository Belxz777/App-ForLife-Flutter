import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String? name;
     final String? description;
       final DateTime? createdAt;
//final bool isCompleted;
final  void Function(bool?)? onChanged;
//final void Function(BuildContext)? editHabit;
final void Function(BuildContext)? deleteHabit;
  const TodoTile({
  super.key,
  required this.name,
  required this.description,
  required this.createdAt,
 // required this.isCompleted,
  required this.onChanged,
  //required this.editHabit,
  required this.deleteHabit,
  });
  @override
  Widget build(BuildContext context) {
    return
     Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
    child:Slidable(  
      endActionPane: ActionPane(
      motion: const StretchMotion() , 
      children: [
SlidableAction(
 onPressed: (context) => {},
//onPressed: editHabit,
backgroundColor: Colors.blue,
icon: Icons.settings,
borderRadius: BorderRadius.circular(10)),
SlidableAction(
  onPressed: deleteHabit,
  backgroundColor: Colors.red,
icon: Icons.delete,
borderRadius: BorderRadius.circular(10))
      ],),
     child:Container(
      decoration:BoxDecoration(
   borderRadius: BorderRadius.circular(10),
        color:  Colors.green ,
      ) ,
    child: ListTile(
      title: Column(

            mainAxisAlignment: MainAxisAlignment.center,

children: [
      Text((name ?? ''),style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
      Text(description ?? '',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
      Text(createdAt.toString() ?? '',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
],
      ), 
      leading: Checkbox(
        activeColor: Color.fromARGB(171, 3, 246, 141),
        value: false,
        onChanged:onChanged ,
      ),
    ),
    padding: EdgeInsets.all(12),
    )));
  }
}