import 'dart:math';

import 'package:axiaworks_flutter_tutorial/birthday/birthday_state_notifier.dart';
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
          child: _buildCard(notifier: notifier),
        ),
      ),
    );
  }

  Widget _buildCard({
    required BirthdayStateNotifier notifier,
  }) {
    final formKey = GlobalKey<FormState>();
    final message = TextEditingController();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _mainContents(),
            Form(
              key: formKey,
              child: TextFormField(
                controller: message,
                decoration: InputDecoration(
                  labelText: 'メッセージを入力してください',
                  hintText: '${birthdayItem.name}へ\nお誕生日おめでとう！',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'メッセージを入力してください';
                  }
                  return null;
                },
              ),
            ),
            spaceH16,
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  notifier.shareMessage(message.text);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: pink, //ボタンの背景色
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
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
    );
  }

  Widget _mainContents() {
    final birthday = formatDays.format(birthdayItem.birthday);
    final year = formatYear.format(birthdayItem.birthday);
    final nowY = formatYear.format(now);

    return Column(
      children: [
        Row(
          children: [
            CommonText(
              text: birthday,
              textSize: 32,
            ),
          ],
        ),
        spaceH16,
        const CommonText(
          text: 'Happy Birthday to',
          textSize: 24,
        ),
        spaceH8,
        CommonText(text: birthdayItem.name, textSize: 24),
        spaceH24,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '👏🏻',
              style: TextStyle(fontSize: 32),
            ),
            Stack(
              children: [
                CommonIcon(
                  icon: birthdayItem.icon,
                  iconSize: 72,
                  circleSize: 160,
                ),
                Positioned(
                  top: -10,
                  child: Transform.rotate(
                    angle: -35 * pi / 180, //60度
                    child: const Text(
                      '👑',
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              '👏🏻',
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
        spaceH16,
        CommonText(text: '$age歳', textSize: 18),
        spaceH16,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText(text: year, textSize: 18),
            nextIcon,
            nextIcon,
            nextIcon,
            CommonText(text: nowY, textSize: 18),
          ],
        ),
        spaceH16,
        Row(
          children: [
            redeemIcon,
            spaceW8,
            CommonText(text: birthdayItem.gift, textSize: 16),
          ],
        ),
      ],
    );
  }
}
