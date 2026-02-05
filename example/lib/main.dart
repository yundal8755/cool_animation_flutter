import 'package:flutter/material.dart';
import 'slide_fade_in_demo.dart';
import 'scale_bounce_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Animation Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainDemoPager(),
    );
  }
}

class MainDemoPager extends StatefulWidget {
  const MainDemoPager({super.key});

  @override
  State<MainDemoPager> createState() => _MainDemoPagerState();
}

class _MainDemoPagerState extends State<MainDemoPager> {
  int _currentIndex = 0;
  final List<Widget> _demos = [
    const SlideFadeInDemo(),
    const ScaleBounceDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _demos[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.swipe),
            label: 'SlideFadeIn',
          ),
          NavigationDestination(
            icon: Icon(Icons.zoom_in),
            label: 'ScaleBounce',
          ),
        ],
      ),
    );
  }
}
