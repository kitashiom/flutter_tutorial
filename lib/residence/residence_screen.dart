import 'package:axiaworks_flutter_tutorial/residence/model/residence_item.dart';
import 'package:axiaworks_flutter_tutorial/residence/residence_client_state_notifier.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResidenceScreen extends ConsumerWidget {
  const ResidenceScreen({super.key});

  static const green = Color(0xff34AFA1);
  static const grey = Color(0xffC9C9C9);
  static const red = Color(0xffF54741);
  static const beige = Color(0xffFAF8F5);
  static const silverWhite = Color(0xffF3F3F3);
  static const lightGrey = Color(0xffE9EFEE);
  static const lightRed = Color(0xffFB715A);
  static const lightBlack = Color(0xff666666);
  static const spaceW4 = SizedBox(width: 4);
  static const spaceW8 = SizedBox(width: 8);
  static const spaceW16 = SizedBox(width: 16);
  static const spaceH4 = SizedBox(height: 4);
  static const spaceH8 = SizedBox(height: 8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(residenceClientStateNotifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context, state.residenceItems),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 3,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Row(
        children: [
          const Chip(
            backgroundColor: lightGrey,
            labelPadding: EdgeInsets.symmetric(horizontal: 8),
            label: Text(
              'カウルのおすすめ',
              style: TextStyle(
                color: green,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          spaceW8,
          Badge(
            position: BadgePosition.topEnd(top: 1, end: -3),
            badgeColor: red,
            elevation: 0,
            badgeContent: const Text(
              '1',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
            child: const Chip(
              backgroundColor: silverWhite,
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
              label: Text(
                'リフォーム済みの',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 16),
          icon: const Icon(
            Icons.add_circle,
            size: 40,
            color: green,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, List<ResidenceItem> residenceItem) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      color: beige,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _residenceSetSection(),
            ListView.builder(
              itemCount: residenceItem.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = residenceItem[index];
                return _roomDetailSection(context, item);
              },
            ),
          ],
        ),
      ),
    );
  }

  //アイコン＆テキストの行
  Row _detailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: lightBlack,
        ),
        spaceW4,
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  //条件選択セクション
  Widget _residenceSetSection() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                spaceW8,
                const Text(
                  'カウルのおすすめ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                spaceW8,
                const Text(
                  '新着３件',
                  style: TextStyle(
                    color: lightRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                const Text(
                  '編集',
                  style: TextStyle(
                    color: green,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.edit,
                        color: green,
                        size: 25,
                      )),
                ),
              ],
            ),
            Card(
              elevation: 0,
              color: beige,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _detailRow(
                      Icons.train,
                      '東京駅・品川駅・川崎駅・横浜駅・目黒駅・恵比寿駅・渋谷駅・',
                    ),
                    spaceH4,
                    _detailRow(
                      Icons.paid,
                      '下限なし 〜 2,000万円',
                    ),
                    spaceH4,
                    _detailRow(
                      Icons.info_outline,
                      '1R 〜 4LDK / 10㎡以上 / 徒歩20分',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //部屋情報セクション
  Widget _roomDetailSection(BuildContext context, ResidenceItem roomInfo) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(roomInfo.imagePath ?? ''),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomInfo.title ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  roomInfo.price ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: lightRed,
                  ),
                ),
                spaceH4,
                _detailRow(Icons.train, roomInfo.access ?? ''),
                spaceH4,
                _detailRow(Icons.dashboard, roomInfo.area ?? ''),
                spaceH4,
                _detailRow(Icons.business, roomInfo.floor ?? ''),
                spaceH8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        8,
                        40,
                        8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: grey,
                          ),
                          spaceW16,
                          Text('興味なし'),
                        ],
                      ),
                    ),
                    spaceW8,
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        8,
                        40,
                        8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.favorite_border,
                            color: grey,
                          ),
                          spaceW16,
                          Text('お気に入り'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return SizedBox(
      height: 64,
      width: 64,
      child: FloatingActionButton.extended(
        backgroundColor: green,
        elevation: 3,
        onPressed: () {},
        label: Column(
          children: const [
            Icon(
              Icons.search,
              size: 30,
            ),
            Text(
              '物件',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: 'ホーム'),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 35,
            ),
            label: 'お気に入り'),
        BottomNavigationBarItem(
            icon: Badge(
              position: BadgePosition.topEnd(top: -5, end: -5),
              badgeColor: red,
              elevation: 0,
              badgeContent: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              child: const Icon(
                Icons.messenger_outline,
                size: 35,
              ),
            ),
            label: 'メッセージ'),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              size: 35,
            ),
            label: 'マイページ'),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: green,
      selectedFontSize: 11,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedIconTheme: const IconThemeData(color: grey),
      unselectedFontSize: 10,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      backgroundColor: Colors.white,
    );
  }
}
