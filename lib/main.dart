import 'package:axiaworks_flutter_tutorial/animation/animation_screen.dart';
import 'package:axiaworks_flutter_tutorial/building/building_layout_screen.dart';
import 'package:axiaworks_flutter_tutorial/mercari/mercari_screen.dart';
import 'package:axiaworks_flutter_tutorial/residence/residence_screen.dart';
import 'package:axiaworks_flutter_tutorial/youtube/youtube_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tutorial'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const BuildingLayoutScreen(),
                  ),
                );
              },
              child: const Text('Tutorial1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const AnimationScreen(),
                  ),
                );
              },
              child: const Text('Tutorial1.1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const YoutubeScreen(),
                  ),
                );
              },
              child: const Text('youtube'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const ResidenceScreen(),
                  ),
                );
              },
              child: const Text('Residence'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const MercariScreen(),
                  ),
                );
              },
              child: const Text('mercari'),
            ),
          ],
        ),
      ),
    );
  }
}
