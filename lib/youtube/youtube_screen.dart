import 'package:flutter/material.dart';

class YoutubeScreen extends StatelessWidget {
  const YoutubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

AppBar _buildAppBar (){
  return AppBar(
    backgroundColor: const Color(0xff2B272C),
    automaticallyImplyLeading: false,
    leading: Row(
      children: [
        const SizedBox(width: 13),
        Image.asset('images/youtube_images/yt_logo_rgb_dark.png',height: 23,),
      ],
    ),
    leadingWidth: 120,
    actions: [
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.cast,size: 25,),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none,size: 25,),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search,size: 25,),
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

Widget _buildBody (BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    padding: const EdgeInsets.all(10),
    color: const Color(0xff1D191E),
    child: Column(
      children: [
        _categoryButton(context,Icons.local_fire_department,'急上昇'),
        _categoryButton(context,Icons.music_note,'音楽'),
        _categoryButton(context,Icons.local_fire_department,'ゲーム'),
        _categoryButton(context,Icons.local_fire_department,'ニュース'),
        _categoryButton(context,Icons.local_fire_department,'学び'),
        _categoryButton(context,Icons.local_fire_department,'ライブ'),
        _categoryButton(context,Icons.local_fire_department,'スポーツ'),
        const Text('youtube'),
      ],
    ),
  );
}

Widget _categoryButton (
    BuildContext context,
    IconData icon,
    String title){
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [
          Color(0xff71122B), //始まりの色
          Color(0xffBA1D46), //終わりの色
        ],
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(width: 10),
        Text(title,
          style: const TextStyle(color: Colors.white),),
      ],
    ),
  );
}

BottomNavigationBar _buildBottomNavigationBar (){
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined,), label: 'ホーム'),
      BottomNavigationBarItem(icon: Icon(Icons.explore), label: '探索'),
      BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 40,), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: '登録チャンネル'),
      BottomNavigationBarItem(icon: Icon(Icons.video_library_outlined), label: 'ライブラリ'),
    ],
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
    selectedFontSize: 10,
    unselectedFontSize: 10,
    backgroundColor: const Color(0xff2B272C),
  );
}