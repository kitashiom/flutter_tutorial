import 'package:flutter/material.dart';

class MovieInfo {
  MovieInfo({
    required this.imagePath,
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  final String imagePath;
  final String iconPath;
  final String title;
  final String subtitle;
}

class YoutubeScreen extends StatelessWidget {
  YoutubeScreen({super.key});

  static const Color backgroundBlackColor = Color(0xff2B272C);

  final List<MovieInfo> _dummyMovieData = [
    MovieInfo(
        imagePath:
            'http://i.ytimg.com/vi/by4SYYWlhEs/hq720.jpg?sqp=-…AFwAcABBg==&rs=AOn4CLByo0DsmXI_XPNDk4sl89hd-mAb7Q',
        iconPath:
            'http://yt3.ggpht.com/ytc/AKedOLQlab7SciC0zKOTNvVomQGmkQpZIr8yRarFZ4HtZw=s88-c-k-c0x00ffffff-no-rj',
        title: '夜に駆ける',
        subtitle: 'Ayase / YOASOBI・1.8億回視聴・2年前'),
    MovieInfo(
        imagePath:
            'http://i.ytimg.com/vi/1tk1pqwrOys/hqdefault.jpg?s…AFwAcABBg==&rs=AOn4CLBYpBZ-dpl7okRTRuaWWLt_3xpdAQ',
        iconPath: '',
        title: '廻廻奇譚 - Eve MV',
        subtitle: 'E ve・2.5億回視聴・1年前'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundBlackColor,
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
                  color: Color(0xffA434BB),
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

  Widget _buildBody(BuildContext context) {
    List<Widget> categoryList = [
      _categoryButton(context, Icons.local_fire_department, '急上昇',
          const Color(0xff71122B), const Color(0xffBA1D46)),
      _categoryButton(context, Icons.music_note, '音楽', const Color(0xff22675D),
          const Color(0xff4DAA99)),
      _categoryButton(context, Icons.sports_esports, 'ゲーム',
          const Color(0xff7C5353), const Color(0xffC7857E)),
      _categoryButton(context, Icons.newspaper, 'ニュース', const Color(0xff114676),
          const Color(0xff0F569D)),
      _categoryButton(context, Icons.tips_and_updates, '学び',
          const Color(0xff125D3E), const Color(0xff128C57)),
      _categoryButton(context, Icons.live_tv, 'ライブ', const Color(0xffB33B0F),
          const Color(0xffF78548)),
      _categoryButton(context, Icons.emoji_events, 'スポーツ',
          const Color(0xff055464), const Color(0xff0D9CC0)),
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff1D191E),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2 / 0.5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: categoryList,
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: Color(0xff39343A),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: backgroundBlackColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '急上昇動画',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  ListView.builder(
                    itemCount: _dummyMovieData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = _dummyMovieData[index];
                      return movieItem(context, item);
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

  Widget _categoryButton(BuildContext context, IconData icon, String title,
      Color colorStart, Color colorEnd) {
    return Container(
      height: 50,
      width: (MediaQuery.of(context).size.width - 32) / 2,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            colorStart, //始まりの色
            colorEnd, //終わりの色
          ],
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget movieItem(BuildContext context, MovieInfo movieInfo) {
    return Column(
      children: [
        Image.network(
          movieInfo.imagePath,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Text('😢');
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(movieInfo.iconPath),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieInfo.title,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      movieInfo.subtitle,
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
                  padding: const EdgeInsets.all(0),
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
            label: 'ホーム'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: '探索'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 40,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_outlined), label: '登録チャンネル'),
        BottomNavigationBarItem(
            icon: Icon(Icons.video_library_outlined), label: 'ライブラリ'),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      backgroundColor: backgroundBlackColor,
    );
  }
}
