import 'package:axiaworks_flutter_tutorial/drift/db/todo_db.dart';
import 'package:axiaworks_flutter_tutorial/drift/todo_client_state_notifier.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< Updated upstream
import 'package:flutter_slidable/flutter_slidable.dart';
=======
>>>>>>> Stashed changes
import 'package:intl/intl.dart';

class TodoScreen extends ConsumerWidget {
  TodoScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _addDate = DateTime.now();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _limitData = TextEditingController();
<<<<<<< Updated upstream
  final format = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoStateNotifierProvider);
    final notifier = ref.watch(todoStateNotifierProvider.notifier);
=======

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoClientStateNotifier);
    final notifier = ref.watch(todoClientStateNotifier.notifier);
>>>>>>> Stashed changes

    return Scaffold(
      body: state.isReadyData
          ? ListView.builder(
              itemCount: state.todoItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = state.todoItems[index];
<<<<<<< Updated upstream
                return _itemCard(item, notifier);
=======
                return _itemCard(item);
>>>>>>> Stashed changes
              },
            )
          : const Center(
              child: Text(
                '登録しているTodoはありません',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
      floatingActionButton: FloatingActionButton(
<<<<<<< Updated upstream
        child: const Icon(Icons.edit),
=======
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
>>>>>>> Stashed changes
        onPressed: () {
          _showDialog(context, notifier);
        },
      ),
    );
  }

<<<<<<< Updated upstream
  Widget _itemCard(
    Todo item,
    TodoStateNotifier notifier,
  ) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              notifier.deleteTodoData(item.id);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          )
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('タイトル：${item.title}'),
                Text(item.description, style: const TextStyle(fontSize: 24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '作成日：${format.format(item.addDate)}',
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      '期日：${format.format(item.limitDate)}',
                      style: const TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
=======
  Widget _itemCard(TodoItemData item) {
    return Card(
      child: Text(item.title),
>>>>>>> Stashed changes
    );
  }

  Future<dynamic> _showDialog(
    BuildContext context,
<<<<<<< Updated upstream
    TodoStateNotifier notifier,
=======
    TodoClientStateNotifier notifier,
>>>>>>> Stashed changes
  ) {
    return showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.text_fields),
                    hintText: 'タイトルを入力してください',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '値を入力してください';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _description,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.notes),
                    hintText: '内容を入力してください',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '値を入力してください';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _limitData,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: '期限を選択してください',
                  ),
<<<<<<< Updated upstream
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2023),
                      helpText: '日付を選択',
                      cancelText: 'キャンセル',
                      confirmText: '決定',
                    );
                    final formatDate = format.format(date!);
=======
                  onTap: () {
                    final formatDate = DateFormat('yyyy-MM-dd').format(
                      DateTime.now(),
                    );
>>>>>>> Stashed changes
                    _limitData.text = formatDate;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '値を入力してください';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('キャンセル'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
<<<<<<< Updated upstream
                        final limitDate = format.parseStrict(_limitData.text);
                        if (_formKey.currentState!.validate()) {
                          final newTodo = TodosCompanion(
=======
                        final limitDate = DateFormat('yyyy-MM-dd')
                            .parseStrict(_limitData.text);
                        if (_formKey.currentState!.validate()) {
                          final newTodo = TodoItemCompanion(
>>>>>>> Stashed changes
                            title: drift.Value(_title.text),
                            description: drift.Value(_description.text),
                            addDate: drift.Value(_addDate),
                            limitDate: drift.Value(limitDate),
                          );
                          notifier.insertTodoData(newTodo);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('保存'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
