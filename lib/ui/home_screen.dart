import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/data/database.dart';
import 'package:todo_app_flutter/utils/dialog_box.dart';
import 'package:todo_app_flutter/utils/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Referencia a la caja de HiveDB
  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    // Si es la primer ves que se abre la aplicación, creara datos predeterminados:
    if(_myBox.get("TODOLIST") == null ){
      db.createInitialData();
    }else {
    // Ya existen datos:
      db.loadData(); 
    }

    super.initState();
  }

  final _controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }
  
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      });
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('To Do App'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.yellow,
          ),
        ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context ,index){
          return TodoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value,index),
            deleteTask: (context) => deleteTask(index),
            );
        }
      )
    );
  }
  
}