import 'package:flutter/material.dart';

class MercariScreen extends StatelessWidget {
  const MercariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
    );
  }
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
