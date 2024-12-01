import 'package:climber/Screens/todo/to_do.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Todo> _todos = [];

  void _addTodo(String title) {
    setState(() {
      _todos.add(Todo(title: title));
    });
    _controller.clear();
  }

  void _toggleTodoCompletion(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  void _removeTodoAt(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      _toggleTodoCompletion(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _removeTodoAt(index);
                    },
                  ),
                );
              },
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary, // Optional: Background color
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary, // Border color
              width: 2, // Border width
            ),
            borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
          ),
          child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration:  InputDecoration(
                        hintText: 'Add new task',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      final text = _controller.text.trim();
                      if (text.isNotEmpty) {
                        _addTodo(text);
                      }
                    },
                  ),
                ],
              ),
        ),
        ],
      ),
    );
  }
}
