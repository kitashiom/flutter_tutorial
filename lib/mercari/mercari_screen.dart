import 'package:flutter/material.dart';

class MercariScreen extends StatelessWidget {
  const MercariScreen({super.key});

  static const Color colorBlack = Color(0xff222222);
  static const Color colorRed = Color(0xffE3463D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 1,
      title: const Text(
        '出品',
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: const Color(0xffEFEFEF),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('images/mercari_images/guide_image.png'),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    '出品へのショートカット',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      shortcutButton(Icons.camera_alt_outlined, '写真を撮る'),
                      shortcutButton(Icons.collections_outlined, 'アルバム'),
                      shortcutButton(Icons.reorder, 'バーコード\n(本・コスメ)'),
                      shortcutButton(Icons.note_alt_outlined, '下書き一覧'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '売れやすい持ち物',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '使わないモノを出品してみよう！',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const Text(
                          'すべて見る ＞',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  itemSection('images/mercari_images/item_image.png',
                      'NikonD5500', '51,000', 446),
                  itemSection('images/mercari_images/item2_image.png',
                      '早い者勝ち！【新品】ERA AAAAA', '15,700', 177),
                  itemSection('images/mercari_images/item_image.png',
                      'NikonD5500', '51,000', 446),
                  itemSection('images/mercari_images/item2_image.png',
                      '早い者勝ち！【新品】ERA AAAAA', '15,700', 177),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //出品へのショートカットのメニューボタン
  Widget shortcutButton(IconData icon, String text) {
    return Card(
      elevation: 1,
      child: Container(
        height: 90,
        width: 80,
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //出品アイテムセクション
  Widget itemSection(
      String imageURL, String title, String price, int peopleNumber) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.3),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            imageURL,
            height: 70,
            width: 70,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '¥$price',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.blue,
                      size: 18,
                    ),
                    Text(
                      ' $peopleNumber人が探しています',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: colorRed,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0)),
            child: const Text(
              '出品する',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'ホーム'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined), label: 'お知らせ'),
        BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: '出品'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'メルペイ'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined), label: 'マイページ'),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: colorBlack,
      unselectedItemColor: colorBlack,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      backgroundColor: Colors.white,
      elevation: 1,
    );
  }
}
