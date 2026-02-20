import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/todo.dart';
import '../services/api_services.dart';
import '../widgets/loading_view.dart';
import '../widgets/error_view.dart';

enum TodoFilter { all, completed, pending }

class TodosScreen extends StatefulWidget {
  final User user;

  const TodosScreen({super.key, required this.user});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final ApiService _api = ApiService();
  late Future<List<Todo>> _futureTodos;
  TodoFilter _filter = TodoFilter.all;

  @override
  void initState() {
    super.initState();
    _futureTodos = _api.fetchTodosByUser(widget.user.id);
  }

  void _retry() {
    setState(() {
      _futureTodos = _api.fetchTodosByUser(widget.user.id);
    });
  }

  List<Todo> _applyFilter(List<Todo> todos) {
    switch (_filter) {
      case TodoFilter.completed:
        return todos.where((t) => t.completed).toList();
      case TodoFilter.pending:
        return todos.where((t) => !t.completed).toList();
      case TodoFilter.all:
      default:
        return todos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos — ${widget.user.name}'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _futureTodos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(message: 'Fetching todos...');
          }

          if (snapshot.hasError) {
            return ErrorView(
              message: snapshot.error.toString(),
              onRetry: _retry,
            );
          }

          final todos = snapshot.data ?? [];
          final completedCount = todos.where((t) => t.completed).length;
          final pendingCount = todos.length - completedCount;

          final filtered = _applyFilter(todos);

          return Column(
            children: [
              // Summary + filter
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total: ${todos.length}  •  Completed: $completedCount  •  Pending: $pendingCount',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    SegmentedButton<TodoFilter>(
                      segments: const [
                        ButtonSegment(
                          value: TodoFilter.all,
                          label: Text('All'),
                        ),
                        ButtonSegment(
                          value: TodoFilter.completed,
                          label: Text('Completed'),
                        ),
                        ButtonSegment(
                          value: TodoFilter.pending,
                          label: Text('Pending'),
                        ),
                      ],
                      selected: {_filter},
                      onSelectionChanged: (set) {
                        setState(() => _filter = set.first);
                      },
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // List
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: Text('No todos for this filter.'))
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final t = filtered[i];
                          return ListTile(
                            title: Text(t.title),
                            leading: Icon(
                              t.completed
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                            ),
                            subtitle:
                                Text(t.completed ? 'Completed' : 'Pending'),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}