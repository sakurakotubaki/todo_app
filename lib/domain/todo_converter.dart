import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/domain/todo.dart';
// todoコレクションを操作するwithConverter

final todoWithConverter = FirebaseFirestore.instance
    .collection('todo')
    .withConverter<Todo>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data()!;
        data['id'] = snapshot.id;
        return Todo.fromJson(data);
      },
      toFirestore: (todo, _) => todo.toJson(),
    );