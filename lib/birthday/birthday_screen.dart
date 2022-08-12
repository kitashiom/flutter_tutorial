import 'package:axiaworks_flutter_tutorial/birthday/birthday_client_state_notifier.dart';
import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BirthdayScreen extends ConsumerWidget {
  BirthdayScreen(this.birthdayItem, this.age, {super.key});

  final Birthday birthdayItem;
  final int age;
  final format = DateFormat('yyyy-MM-dd');
  static const green = Color(0xFF377D71);
  static const pink = Color(0xffFBA1A1);
  static const spaceW8 = SizedBox(
    width: 8,
  );
  static const spaceH16 = SizedBox(
    height: 16,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(birthdayStateNotifierProvider);
    final notifier = ref.watch(birthdayStateNotifierProvider.notifier);
    final message = TextEditingController();
    final birthday = DateFormat('Md').format(birthdayItem.birthday);
    final year = DateFormat('y').format(birthdayItem.birthday);
    final nowY = DateFormat('y').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        color: green,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        birthday,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Happy Birthday to',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        birthdayItem.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: pink,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            birthdayItem.icon,
                            style: const TextStyle(
                              fontSize: 48,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Text(
                        '$age歳',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            year,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.navigate_next,
                            color: pink,
                          ),
                          const Icon(
                            Icons.navigate_next,
                            color: pink,
                          ),
                          const Icon(
                            Icons.navigate_next,
                            color: pink,
                          ),
                          Text(
                            nowY,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.redeem,
                            color: pink,
                          ),
                          spaceW8,
                          Text(
                            birthdayItem.gift,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: message,
                        decoration: InputDecoration(
                          labelText: 'メッセージを入力してください',
                          hintText: '${birthdayItem.name}へ\nお誕生日おめでとう！',
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '値を入力してください';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: pink, //ボタンの背景色
                        ),
                        child: Text(
                          '${birthdayItem.name}に\nメッセージを送る',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
