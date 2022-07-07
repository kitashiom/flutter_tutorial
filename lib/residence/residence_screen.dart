import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ResidenceScreen extends StatelessWidget {
  const ResidenceScreen({super.key});

  static const pointColorGreen = Color(0xff34AFA1);
  static const pointColorGrey = Color(0xffC9C9C9);
  static const badgeBackColor = Color(0xffF54741);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
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
          const SizedBox(width: 8),
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
