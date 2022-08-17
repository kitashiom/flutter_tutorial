import 'dart:math';

import 'package:age_calculator/age_calculator.dart';
import 'package:axiaworks_flutter_tutorial/birthday/birthday_screen.dart';
import 'package:axiaworks_flutter_tutorial/birthday/birthday_state_notifier.dart';
import 'package:axiaworks_flutter_tutorial/birthday/common_icon.dart';
import 'package:axiaworks_flutter_tutorial/birthday/common_text.dart';
import 'package:axiaworks_flutter_tutorial/birthday/constants.dart';
import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:axiaworks_flutter_tutorial/birthday/menu_enum.dart';
import 'package:axiaworks_flutter_tutorial/birthday/state/birthday_client_state.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BirthdayListScreen extends ConsumerWidget {
  const BirthdayListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(birthdayStateNotifierProvider);
    final notifier = ref.watch(birthdayStateNotifierProvider.notifier);

    return Scaffold(
      appBar: _buildAppBar(state: state),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        color: green,
        child: !state.isReadyData
            ? _buildEmptyBody()
            : _buildBody(
                context: context,
                state: state,
                notifier: notifier,
              ),
      ),
      floatingActionButton: _buildFloatingActionButton(
        context: context,
        notifier: notifier,
      ),
    );
  }

  AppBar _buildAppBar({
    required BirthdayClientState state,
  }) {
    return AppBar(
      title: CommonText(
        text: state.isTodayBirthday == false
            ? 'Birthday List'
            : "🎉 Today's Birthday 🎉",
        textSize: 24,
      ),
      centerTitle: true,
      backgroundColor: green,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildEmptyBody() {
    return const Center(
      child: Text(
        '登録している誕生日はありません',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required BirthdayClientState state,
    required BirthdayStateNotifier notifier,
  }) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH32,
          ListView.separated(
            itemCount: state.birthdayItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final birthdayItem = state.birthdayItems[index];
              return _birthdayListCard(
                context: context,
                state: state,
                notifier: notifier,
                birthdayItem: birthdayItem,
                index: index,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return spaceH32;
            },
          ),
        ],
      ),
    );
  }

  Widget _birthdayListCard({
    required BuildContext context,
    required BirthdayClientState state,
    required BirthdayStateNotifier notifier,
    required Birthday birthdayItem,
    required int index,
  }) {
    //月日のみ
    final date = formatDays.format(birthdayItem.birthday);
    //年のみ
    final year = formatYear.format(birthdayItem.birthday);
    //誕生年を現在に変換したもの
    final nowYearBirthday = DateTime(
      nowDate.year,
      birthdayItem.birthday.month,
      birthdayItem.birthday.day,
    );
    //今の年齢
    final age = AgeCalculator.age(birthdayItem.birthday).years;
    //次の年齢
    final nextAge = AgeCalculator.age(birthdayItem.birthday).years + 1;
    //残日数
    final countdown = notifier.calculateCountdown(nowYearBirthday);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !state.isTodayBirthday && index == 0,
          child: Text(
            '　残り$countdown日',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CommonText(
                              text: date,
                              textSize: 32,
                            ),
                            CommonText(
                              text: '($year)',
                              textSize: 16,
                            )
                          ],
                        ),
                        PopupMenuButton<Menu>(
                          onSelected: (menu) {
                            if (menu == Menu.update) {
                              _showDialog(
                                context: context,
                                notifier: notifier,
                                menu: Menu.update,
                                birthdayItem: birthdayItem,
                              );
                            } else if (menu == Menu.delete) {
                              notifier.deleteBirthdayData(birthdayItem.id);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<Menu>>[
                            const PopupMenuItem(
                              value: Menu.update,
                              child: Text('編集'),
                            ),
                            const PopupMenuItem(
                              value: Menu.delete,
                              child: Text('削除'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      child: CommonText(
                        text: birthdayItem.name,
                        textSize: 18,
                      ),
                    ),
                    spaceH16,
                    Row(
                      children: [
                        nextIcon,
                        spaceW8,
                        CommonText(
                          text: '$age歳 → $nextAge歳',
                          textSize: 16,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        redeemIcon,
                        spaceW8,
                        CommonText(
                          text: birthdayItem.gift,
                          textSize: 16,
                        ),
                      ],
                    ),
                    Visibility(
                      visible: nowYearBirthday == nowDate,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    BirthdayScreen(birthdayItem, nextAge),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: pink, //ボタンの背景色
                          ),
                          child: const Text('BirthdayScreenへ'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -30,
              left: (MediaQuery.of(context).size.width - 116) / 2,
              child: GestureDetector(
                onTap: () => notifier.changeIcon(birthdayItem),
                child: Stack(
                  children: [
                    CommonIcon(
                      icon: birthdayItem.icon,
                      iconSize: 48,
                      circleSize: 100,
                    ),
                    Visibility(
                      visible: nowYearBirthday == nowDate,
                      child: Positioned(
                        top: -10,
                        child: Transform.rotate(
                          angle: -35 * pi / 180, //-35度
                          child: const Text(
                            '👑',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  FloatingActionButton _buildFloatingActionButton({
    required BuildContext context,
    required BirthdayStateNotifier notifier,
  }) {
    return FloatingActionButton(
      backgroundColor: pink,
      child: const Icon(
        Icons.edit,
      ),
      onPressed: () {
        _showDialog(
          context: context,
          notifier: notifier,
          menu: Menu.write,
        );
      },
    );
  }

  Future<dynamic> _showDialog({
    required BuildContext context,
    required BirthdayStateNotifier notifier,
    required Menu menu,
    Birthday? birthdayItem,
  }) {
    final formKey = GlobalKey<FormState>();
    final name = TextEditingController();
    final birthday = TextEditingController();
    final gift = TextEditingController();

    if (menu == Menu.update && birthdayItem != null) {
      name.text = birthdayItem.name;
      final formatDate = formatDefault.format(birthdayItem.birthday);
      birthday.text = formatDate;
      gift.text = birthdayItem.gift;
    }

    return showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: '名前',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '名前を入力してください';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: birthday,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: '誕生日',
                  ),
                  onTap: () async {
                    final datetime = await showDatePicker(
                      context: context,
                      initialDate: menu == Menu.update && birthdayItem != null
                          ? birthdayItem.birthday
                          : now,
                      firstDate: DateTime(1900),
                      lastDate: now,
                      helpText: '日付を選択',
                      confirmText: '決定',
                    );
                    if (datetime != null) {
                      final formatDate = formatDefault.format(datetime);
                      birthday.text = formatDate;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '誕生日を入力してください';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: gift,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.notes),
                    hintText: '贈る予定のプレゼント',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'プレゼントを入力してください';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: menu == Menu.write
                      ? () {
                          //新規保存
                          if (formKey.currentState!.validate()) {
                            final birthdayData =
                                formatDefault.parseStrict(birthday.text);
                            final newBirthday = BirthdaysCompanion(
                              icon: const drift.Value('👩🏻'),
                              name: drift.Value(name.text),
                              birthday: drift.Value(birthdayData),
                              gift: drift.Value(gift.text),
                              createdAt: drift.Value(now),
                              updateAt: drift.Value(now),
                            );
                            notifier.insertBirthdayData(newBirthday);
                            Navigator.pop(context);
                          }
                        }
                      : () {
                          //更新
                          if (formKey.currentState!.validate() &&
                              birthdayItem != null) {
                            final birthdayData =
                                formatDefault.parseStrict(birthday.text);
                            final newBirthday = BirthdaysCompanion(
                              id: drift.Value(birthdayItem.id),
                              icon: drift.Value(birthdayItem.icon),
                              name: drift.Value(name.text),
                              birthday: drift.Value(birthdayData),
                              gift: drift.Value(gift.text),
                              createdAt: drift.Value(birthdayItem.createdAt),
                              updateAt: drift.Value(now),
                            );
                            notifier.updateBirthdayData(newBirthday);
                            Navigator.pop(context);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    primary: pink, //背景色
                  ),
                  child:
                      menu == Menu.write ? const Text('保存') : const Text('更新'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
