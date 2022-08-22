import 'dart:math';

import 'package:age_calculator/age_calculator.dart';
import 'package:axiaworks_flutter_tutorial/birthday/commons/common_icon.dart';
import 'package:axiaworks_flutter_tutorial/birthday/commons/common_text.dart';
import 'package:axiaworks_flutter_tutorial/birthday/constants.dart';
import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:axiaworks_flutter_tutorial/birthday/screen/birthday_screen/birthday_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BirthdayScreen extends ConsumerWidget {
  const BirthdayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(birthdayStateNotifierProvider);
    final notifier = ref.watch(birthdayStateNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
      ),
      body: state.currentItem == null
          ? _buildEmptyBody()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(8),
              color: green,
              child: SingleChildScrollView(
                child: _buildCard(item: state.currentItem!, notifier: notifier),
              ),
            ),
    );
  }

  Widget _buildEmptyBody() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildCard({
    required Birthday item,
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
            _buildMainContents(item: item),
            Form(
              key: formKey,
              child: TextFormField(
                controller: message,
                decoration: InputDecoration(
                  labelText: 'メッセージを入力してください',
                  hintText: '${item.name}へ\nお誕生日おめでとう！',
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
                '${item.name}に\nメッセージを送る',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContents({required Birthday item}) {
    final birthday = formatDays.format(item.birthday);
    final year = formatYear.format(item.birthday);
    final nowY = formatYear.format(now);
    final age = AgeCalculator.age(item.birthday).years;

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
        CommonText(text: item.name, textSize: 24),
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
                  icon: item.icon,
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
            CommonText(text: item.gift, textSize: 16),
          ],
        ),
      ],
    );
  }
}
