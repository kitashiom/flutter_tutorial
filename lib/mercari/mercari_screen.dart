import 'package:axiaworks_flutter_tutorial/mercari/mercari_client_state_notifier.dart';
import 'package:axiaworks_flutter_tutorial/mercari/model/mercari_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MercariScreen extends ConsumerWidget {
  const MercariScreen({super.key});

  static const Color red = Color(0xffE3463D);
  static const Color grey = Color(0xffEFEFEF);
  static const spaceH24 = SizedBox(height: 24);
  static const spaceH16 = SizedBox(height: 16);
  static const spaceH8 = SizedBox(height: 8);
  static const spaceH4 = SizedBox(height: 4);
  static const spaceW8 = SizedBox(width: 8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mercariClientStateNotifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context, state.mercariItems),
      floatingActionButton: _buildFloatingActionButton(),
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
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<MercariItem> mercariItem) {
    return ColoredBox(
      color: grey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('images/mercari_images/guide_image.png'),
                  spaceH24,
                  const Text(
                    '出品へのショートカット',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  spaceH16,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '売れやすい持ち物',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '使わないモノを出品してみよう！',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'すべて見る ＞',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  spaceH16,
                  ListView.builder(
                    itemCount: mercariItem.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = mercariItem[index];
                      return _itemSection(item);
                    },
                  ),
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
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            spaceH8,
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
  Widget _itemSection(MercariItem itemInfo) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.3),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            itemInfo.imagePath ?? '',
            height: 70,
            width: 70,
          ),
          spaceW8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemInfo.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                spaceH4,
                Text(
                  '¥${itemInfo.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                spaceH4,
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.blue,
                      size: 18,
                    ),
                    Text(
                      '${itemInfo.numOfViews}人が探しています',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
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
              primary: red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              '出品する',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
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
        backgroundColor: red,
        elevation: 3,
        onPressed: () {},
        label: Column(
          children: const [
            Icon(
              Icons.camera_alt,
              size: 24,
            ),
            Text(
              '出品',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
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
          label: 'ホーム',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none_outlined),
          label: 'お知らせ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: '出品',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: 'メルペイ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'マイページ',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      backgroundColor: Colors.white,
    );
  }
}
