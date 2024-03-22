import 'package:flutter/material.dart';
import 'package:todo_app/application/todo_api.dart';
import 'package:todo_app/domain/todo.dart';

class EditTodoView extends StatefulWidget {
  const EditTodoView({super.key, required this.todo});

  final Todo todo;

  @override
  State<EditTodoView> createState() => _EditTodoViewState();
}

class _EditTodoViewState extends State<EditTodoView> {
  final _titleController = TextEditingController();

  // nullだったらエラーを出すgetter
  String? get _title =>
      _titleController.text.isNotEmpty ? _titleController.text : null;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoAPI = TodoAPIImpl();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_title != null) {
                  final todoId = widget.todo.id;
                  final todo = Todo(
                    id: todoId,
                    title: _title,
                  );
                  await todoAPI.editTodo(todo);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Formに値を入力してください'),
                    ),
                  );
                }
              },
              child: const Text('編集'),
            ),
          ],
        ),
      ),
    );
  }
}
