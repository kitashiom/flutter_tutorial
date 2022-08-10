import 'package:age_calculator/age_calculator.dart';
import 'package:axiaworks_flutter_tutorial/birthday/birthday_client_state_notifier.dart';
import 'package:axiaworks_flutter_tutorial/birthday/birthday_screen.dart';
import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BirthdayListScreen extends ConsumerWidget {
  BirthdayListScreen({super.key});

  List<Birthday> list = [];
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat('yyyy-MM-dd');
  final now = DateTime.now();
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("My friend's Birthday"),
        centerTitle: true,
        backgroundColor: green,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: state.isReadyData
          ? Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              color: const Color(0xffE1ECEC),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'next',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    ListView.separated(
                      itemCount: state.birthdayItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final birthdayItem = state.birthdayItems[index];
                        return _birthdayListCard(
                          context,
                          notifier,
                          birthdayItem,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 32,
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: Text(
                '登録している誕生日はありません',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }

  Widget _birthdayListCard(
    BuildContext context,
    BirthdayStateNotifier notifier,
    Birthday birthdayItem,
  ) {
    final birthday = DateFormat('Md').format(birthdayItem.birthday);
    final nextAge = AgeCalculator.age(birthdayItem.birthday).years + 1;

    return SizedBox(
      child: Stack(
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
                      Text(
                        birthday,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
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
                  spaceH16,
                  Align(
                    child: Text(
                      birthdayItem.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.navigate_next,
                        color: pink,
                      ),
                      spaceW8,
                      Text(
                        '${nextAge.toString()}歳',
                        style: const TextStyle(
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => BirthdayScreen(birthdayItem),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: pink, //ボタンの背景色
                    ),
                    child: const Text('BirthdayScreenへ'),
                  ),
                  Text(
                    format.format(birthdayItem.birthday),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    format.format(birthdayItem.createdAt),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    format.format(birthdayItem.updateAt),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: (MediaQuery.of(context).size.width - 116) / 2,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '👩🏻',
                style: TextStyle(
                  fontSize: 48,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showDialog({
    required BuildContext context,
    required BirthdayStateNotifier notifier,
    required Menu menu,
    Birthday? birthdayItem,
  }) {
    final name = TextEditingController();
    final birthday = TextEditingController();
    final gift = TextEditingController();
    int? id;
    DateTime? createdAt;

    if (menu == Menu.update && birthdayItem != null) {
      name.text = birthdayItem.name;
      final formatDate = format.format(birthdayItem.birthday);
      birthday.text = formatDate;
      gift.text = birthdayItem.gift;
      id = birthdayItem.id;
      createdAt = birthdayItem.createdAt;
    }

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
                  controller: name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: '名前',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '値を入力してください';
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
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      helpText: '日付を選択',
                      confirmText: '決定',
                    );
                    final formatDate = format.format(date!);
                    birthday.text = formatDate;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '値を入力してください';
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
                      return '値を入力してください';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: menu == Menu.write
                      ? () {
                          final birthdayData =
                              format.parseStrict(birthday.text);
                          if (_formKey.currentState!.validate()) {
                            final newBirthday = BirthdaysCompanion(
                              name: drift.Value(name.text),
                              birthday: drift.Value(birthdayData),
                              gift: drift.Value(gift.text),
                              createdAt: drift.Value(
                                DateTime.now(),
                              ),
                              updateAt: drift.Value(
                                DateTime.now(),
                              ),
                            );
                            notifier.insertBirthdayData(newBirthday);
                            Navigator.pop(context);
                          }
                        }
                      : () {
                          final birthdayData =
                              format.parseStrict(birthday.text);
                          if (_formKey.currentState!.validate()) {
                            final newBirthday = BirthdaysCompanion(
                              id: drift.Value(id!),
                              name: drift.Value(name.text),
                              birthday: drift.Value(birthdayData),
                              gift: drift.Value(gift.text),
                              createdAt: drift.Value(createdAt!),
                              updateAt: drift.Value(
                                DateTime.now(),
                              ),
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

enum Menu {
  write,
  update,
  delete,
}
