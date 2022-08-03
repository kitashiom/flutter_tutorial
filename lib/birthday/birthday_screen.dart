import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  const BirthdayScreen({super.key});

  static const pink = Color(0xffFBA1A1);
  static const spaceW8 = SizedBox(
    width: 8,
  );
  static const spaceH16 = SizedBox(
    height: 16,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = [
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("My friend's Birthday"),
        centerTitle: true,
        backgroundColor: const Color(0xFF377D71),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: pink,
        child: const Icon(
          Icons.edit,
        ),
        onPressed: () {},
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                fontSize: 40,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
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
      ),
    );
  }
}
