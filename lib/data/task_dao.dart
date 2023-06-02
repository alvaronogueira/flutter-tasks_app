import 'package:first_project/components/task.dart';
import 'package:first_project/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';
  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';


  save(Task tarefa) async {
    print('Starting save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print('The task did not exist');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('The task did exist already');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('Converting Task in Map: ');
    final Map<String, dynamic> mapOftasks = Map();
    mapOftasks[_name] = tarefa.nome;
    mapOftasks[_difficulty] = tarefa.difficulty;
    mapOftasks[_image] = tarefa.image;
    print('mMap of Tasks: $mapOftasks');
    return mapOftasks;
  }

  Future<List<Task>> findAll() async {
    print('Accessing findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Searching data in database... found: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapOfTasks) {
    print('Converting to List');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapOfTasks) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print('List of Tasks $tarefas');
    return tarefas;
  }

  Future<List<Task>> find(String nameOfActivity) async {
    print('Accessing find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nameOfActivity],
    );
    print('Found task: ${toList(result)}');
    return toList(result);
  }

  delete(String nameOfActivity) async {
    print('Deleting task: $nameOfActivity');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nameOfActivity],
    );
  }


}
