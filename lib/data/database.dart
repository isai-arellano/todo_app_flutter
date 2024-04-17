import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [ ];

  // Referencia a caja HiveDB
  final _myBox = Hive.box('myBox');

  // Esta función se ejecutara la primer ves que se abra la aplicación:
  void createInitialData(){
    toDoList = [
      ['Hacer ejercicio', true],
      ['Crear tutorial', false]
    ];
  }

  // Cargar datos de la base de datos:
  void loadData(){
     toDoList = _myBox.get('TODOLIST');
  }

  // Actualizar base de datos:
  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);
  }

}