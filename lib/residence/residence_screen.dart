import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ResidenceScreen extends StatelessWidget {
  const ResidenceScreen({super.key});

  static const pointColorGreen = Color(0xff34AFA1);
  static const pointColorGrey = Color(0xffC9C9C9);
  static const pointColorRed = Color(0xffFB715A);
  static const pointColorBeige = Color(0xffFAF8F5);
  static const badgeBackColor = Color(0xffF54741);
  static const SizedBox spaceW4 = SizedBox(
    width: 4,
  );
  static const SizedBox spaceW8 = SizedBox(
    width: 8,
  );
  static const SizedBox spaceW16 = SizedBox(
    width: 16,
  );
  static const SizedBox spaceH4 = SizedBox(
    height: 4,
  );
  static const SizedBox spaceH8 = SizedBox(
    height: 8,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
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
            backgroundColor: Color(0xffE9EFEE),
            labelPadding: EdgeInsets.symmetric(horizontal: 8),
            label: Text(
              'カウルのおすすめ',
              style: TextStyle(
                  color: pointColorGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          spaceW8,
          Badge(
            position: BadgePosition.topEnd(top: 1, end: -3),
            badgeColor: badgeBackColor,
            elevation: 0,
            badgeContent: const Text(
              '1',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
            child: const Chip(
              backgroundColor: Color(0xffF3F3F3),
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
            color: pointColorGreen,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      color: pointColorBeige,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _residenceSetSection(),
            _roomDetailSection(context),
            _roomDetailSection(context),
            _roomDetailSection(context),
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
          color: const Color(0xff666666),
        ),
        spaceW4,
        Text(
          text,
          style: const TextStyle(fontSize: 11),
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
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                spaceW8,
                const Text(
                  'カウルのおすすめ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                spaceW8,
                const Text(
                  '新着３件',
                  style: TextStyle(
                      color: pointColorRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                const Spacer(),
                const Text(
                  '編集',
                  style: TextStyle(color: pointColorGreen, fontSize: 12),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.edit,
                        color: pointColorGreen,
                        size: 25,
                      )),
                ),
              ],
            ),
            Card(
              elevation: 0,
              color: pointColorBeige,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    _detailRow(Icons.train, '東京駅・品川駅・川崎駅・横浜駅・目黒駅・恵比寿駅・渋谷駅・'),
                    spaceH4,
                    _detailRow(Icons.paid, '下限なし 〜 2,000万円'),
                    spaceH4,
                    _detailRow(Icons.info_outline, '1R 〜 4LDK / 10㎡以上 / 徒歩20分'),
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
  Widget _roomDetailSection(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('images/residence_images/residence_image.png'),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rising place川崎',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '2,000万円',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: pointColorRed),
                ),
                spaceH4,
                _detailRow(Icons.train, '京急本線 京急川崎駅 より 徒歩9分'),
                spaceH4,
                _detailRow(Icons.dashboard, '1K / 21.24㎡ 南西向き'),
                spaceH4,
                _detailRow(Icons.business, '2階 / 15階建 築5年'),
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
                        border: Border.all(color: pointColorGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: pointColorGrey,
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
                        border: Border.all(color: pointColorGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.favorite_border,
                            color: pointColorGrey,
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
        backgroundColor: pointColorGreen,
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
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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
              badgeColor: badgeBackColor,
              elevation: 0,
              badgeContent: const Text(
                '1',
                style: TextStyle(color: Colors.white, fontSize: 13),
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
      selectedItemColor: pointColorGreen,
      selectedFontSize: 11,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedIconTheme: const IconThemeData(color: pointColorGrey),
      unselectedFontSize: 10,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      backgroundColor: Colors.white,
    );
  }
}
