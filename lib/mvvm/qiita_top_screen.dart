import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QiitaTopScreen extends ConsumerWidget {
  const QiitaTopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QiitaClientSample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Flutter'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('android'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('ios'),
            ),
          ],
        ),
      ),
    );
  }
}
