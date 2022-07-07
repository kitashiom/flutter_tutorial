import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ResidenceScreen extends StatelessWidget {
  const ResidenceScreen({super.key});

  static const greenPointColor = Color(0xff34AFA1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
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
                  color: greenPointColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Badge(
            position: BadgePosition.topEnd(top: 1, end: -3),
            badgeColor: const Color(0xffF54741),
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
            color: greenPointColor,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
