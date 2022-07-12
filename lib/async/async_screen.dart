import 'package:flutter/material.dart';

class AsyncScreen extends StatelessWidget {
  const AsyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('名前： kitashio'),
            Text('年齢： 21'),
            Text('誕生日： 1/6'),
          ],
        ),
      ),
    );
  }
}
