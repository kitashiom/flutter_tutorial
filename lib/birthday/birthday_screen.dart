import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Birthday {
  Birthday({
    required this.name,
    required this.birthday,
    required this.gift,
  });

  final String name;
  final String birthday;
  final String gift;
}

class BirthdayScreen extends ConsumerWidget {
  BirthdayScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final format = DateFormat('yyyy-MM-dd');
  static const green = Color(0xFF377D71);
  static const pink = Color(0xffFBA1A1);
  static const spaceW8 = SizedBox(
    width: 8,
  );
  static const spaceH16 = SizedBox(
    height: 16,
  );

  final List<Birthday> list = [
    Birthday(
      name: 'misumi',
      birthday: '12/6',
      gift: 'リップ＆靴',
    ),
    Birthday(
      name: 'mirei',
      birthday: '2/24',
      gift: 'リップ＆靴',
    ),
    Birthday(
      name: 'natsuki',
      birthday: '8/8',
      gift: 'リップ＆靴',
    ),
    Birthday(
      name: 'natsuki',
      birthday: '8/8',
      gift: 'リップ＆靴',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My friend's Birthday"),
        centerTitle: true,
        backgroundColor: green,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: pink,
        child: const Icon(
          Icons.edit,
        ),
        onPressed: () {
          _showDialog(context);
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        color: const Color(0xffE1ECEC),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'next',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ListView.separated(
                itemCount: list.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = list[index];
                  return _buildListCard(context, item);
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
      ),
    );
  }

  Widget _buildListCard(BuildContext context, Birthday item) {
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
                        item.birthday,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 25,
                        child: IconButton(
                          onPressed: () {},
                          alignment: Alignment.topRight,
                          icon: const Icon(Icons.more_horiz),
                        ),
                      ),
                    ],
                  ),
                  spaceH16,
                  Align(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.navigate_next,
                        color: pink,
                      ),
                      spaceW8,
                      Text(
                        '21歳',
                        style: TextStyle(
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
                        item.gift,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

  Future<dynamic> _showDialog(
    BuildContext context,
  ) {
    final title = TextEditingController();
    final description = TextEditingController();
    final limitData = TextEditingController();

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
                  controller: title,
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
                  controller: limitData,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: '誕生日',
                  ),
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
                    limitData.text = formatDate;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '値を入力してください';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: description,
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: pink, //背景色
                  ),
                  child: const Text('保存'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
