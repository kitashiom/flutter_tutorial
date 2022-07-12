import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AsyncScreen extends StatefulWidget {
  const AsyncScreen({Key? key}) : super(key: key);

  @override
  State<AsyncScreen> createState() => _AsyncScreen();
}

class _AsyncScreen extends State<AsyncScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '未設定';
  String _age = '未設定';
  String _birthday = '未設定';

  @override
  void initState() {
    super.initState();
    _checkData();
  }

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

  Future<void> _setData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs
        ..setString('name', _name)
        ..setString('age', _age)
        ..setString('birthday', _birthday);
    });
  }

  Future<void> _checkData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '未設定';
      _age = prefs.getString('age') ?? '未設定';
      _birthday = prefs.getString('birthday') ?? '未設定';
    });
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('名前： $_name'),
          Text('年齢： $_age'),
          Text('誕生日： $_birthday'),
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
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '名前',
                    ),
                    onChanged: (value) {
                      _name = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '名前を入力してください';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '年齢',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      _age = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '年齢を入力してください';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '誕生日',
                    ),
                    onChanged: (value) {
                      _birthday = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '誕生日を入力してください';
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
                          if (_formKey.currentState!.validate()) {
                            _setData();
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
        });
  }
}
