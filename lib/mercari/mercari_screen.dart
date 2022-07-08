import 'package:flutter/material.dart';

class MercariScreen extends StatelessWidget {
  const MercariScreen({super.key});

  static const Color colorBlack = Color(0xff222222);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
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
            fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
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
    );
  }
}
