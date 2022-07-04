import 'package:flutter/material.dart';

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tutorial'),
      ),
      body: Center(
        child: Text('Tutorial1.1'),
      ),
    );
  }
}
