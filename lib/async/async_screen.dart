import 'package:flutter/material.dart';

class AsyncScreen extends StatelessWidget {
  const AsyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        elevation: 3,
        child: const Icon(Icons.add),
        onPressed: () {
          _showDialog(context);
        },
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('名前： 未設定'),
          Text('年齢： 未設定'),
          Text('誕生日： 未設定'),
        ],
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('登録'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '名前',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '年齢',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '誕生日',
                  ),
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
                      onPressed: () {},
                      child: const Text('保存'),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
