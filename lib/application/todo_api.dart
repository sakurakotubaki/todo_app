import 'package:todo_app/domain/todo.dart';
import 'package:todo_app/domain/todo_converter.dart';

abstract interface class TodoAPI {
  Stream<List<Todo>> getTodo();
  Future<void> addTodo(Todo todo);
  Future<void> editTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
}

class TodoAPIImpl implements TodoAPI {

  @override
  Stream<List<Todo>> getTodo() {
    return todoWithConverter.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Future<void> addTodo(Todo todo) {
    return todoWithConverter.add(todo);
  }

  @override
  Future<void> editTodo(Todo todo) {
    return todoWithConverter.doc(todo.id).update(todo.toJson());
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return todoWithConverter.doc(todo.id).delete();
  }
}
