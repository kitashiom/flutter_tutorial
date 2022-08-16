import 'package:axiaworks_flutter_tutorial/birthday/birthday_client_state_notifier.dart';
import 'package:axiaworks_flutter_tutorial/birthday/common_icon.dart';
import 'package:axiaworks_flutter_tutorial/birthday/common_text.dart';
import 'package:axiaworks_flutter_tutorial/birthday/constants.dart';
import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BirthdayScreen extends ConsumerWidget {
  const BirthdayScreen(this.birthdayItem, this.age, {super.key});

  final Birthday birthdayItem;
  final int age;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(birthdayStateNotifierProvider.notifier);
    final message = TextEditingController();
    final birthday = formatDefault.format(birthdayItem.birthday);
    final year = formatYear.format(birthdayItem.birthday);
    final nowY = formatYear.format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
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
                      CommonText(text: birthday, textSize: 32),
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
                      CommonIcon(
                        icon: birthdayItem.icon,
                        iconSize: 72,
                        circleSize: 160,
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
                          nextIcon,
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
                        onPressed: () {
                          notifier.shareMessage(message.text);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: pink, //ボタンの背景色
                        ),
                        child: Text(
                          '${birthdayItem.name}に\nメッセージを送る',
                          textAlign: TextAlign.center,
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
