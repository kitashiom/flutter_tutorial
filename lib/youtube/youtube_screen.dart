import 'package:axiaworks_flutter_tutorial/youtube/model/youtube_item.dart';
import 'package:axiaworks_flutter_tutorial/youtube/youtube_client_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YoutubeScreen extends ConsumerWidget {
  const YoutubeScreen({super.key});

  static const Color black = Color(0xff2B272C);
  static const Color darkBlack = Color(0xff1D191E);
  static const Color darkGrey = Color(0xff39343A);
  static const Color purple = Color(0xffA434BB);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(youtubeClientStateNotifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context, state.youtubeItems),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: black,
      automaticallyImplyLeading: false,
      leading: Row(
        children: [
          const SizedBox(width: 16),
          Image.asset(
            'images/youtube_images/yt_logo_rgb_dark.png',
            height: 23,
          ),
        ],
      ),
      leadingWidth: 120,
      actions: [
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.cast,
                size: 25,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                size: 25,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 27,
                width: 27,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: purple,
                  shape: BoxShape.circle,
                ),
                child: const Text('t'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, List<YoutubeItem> youtubeItems) {
    final categoryList = <Widget>[
      _categoryButton(
        context,
        Icons.local_fire_department,
        '急上昇',
        const Color(0xff71122B),
        const Color(0xffBA1D46),
      ),
      _categoryButton(
        context,
        Icons.music_note,
        '音楽',
        const Color(0xff22675D),
        const Color(0xff4DAA99),
      ),
      _categoryButton(
        context,
        Icons.sports_esports,
        'ゲーム',
        const Color(0xff7C5353),
        const Color(0xffC7857E),
      ),
      _categoryButton(
        context,
        Icons.newspaper,
        'ニュース',
        const Color(0xff114676),
        const Color(0xff0F569D),
      ),
      _categoryButton(
        context,
        Icons.tips_and_updates,
        '学び',
        const Color(0xff125D3E),
        const Color(0xff128C57),
      ),
      _categoryButton(
        context,
        Icons.live_tv,
        'ライブ',
        const Color(0xffB33B0F),
        const Color(0xffF78548),
      ),
      _categoryButton(
        context,
        Icons.emoji_events,
        'スポーツ',
        const Color(0xff055464),
        const Color(0xff0D9CC0),
      ),
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      color: darkBlack,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 4 / 1,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: categoryList,
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: darkGrey,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '急上昇動画',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: youtubeItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = youtubeItems[index];
                      return _movieItem(context, item);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(
    BuildContext context,
    IconData icon,
    String title,
    Color colorStart,
    Color colorEnd,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            colorStart,
            colorEnd,
          ],
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _movieItem(BuildContext context, YoutubeItem item) {
    return Column(
      children: [
        Image.network(
          item.imagePath ?? '',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Text('Error');
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  item.iconPath ?? '',
                  height: 33,
                  width: 33,
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) {
                    return const Text('Error');
                  },
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? '',
                      maxLines: 2,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${item.channelName ?? ''}・${item.numOfViews ?? ''}・${item.daysAgo ?? ''}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.more_vert_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: '探索'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle_outline,
            size: 40,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions_outlined),
          label: '登録チャンネル',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library_outlined),
          label: 'ライブラリ',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      backgroundColor: black,
    );
  }
}
