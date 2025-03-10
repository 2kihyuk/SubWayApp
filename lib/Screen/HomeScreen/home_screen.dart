import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privateapp/Screen/SubWay/subway_main.dart';
import 'package:privateapp/Screen/Chart/chart.dart';
import 'package:privateapp/Screen/Default_layout/default_layout.dart';
import 'package:privateapp/Screen/Chart/pie_chart_sample3.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: TabBarView(
        controller: controller,
        children: [
          SubwayMain(),
          Center(
            child: Container(
              child: Text('홈'),
            ),
          ),
          Container(
            child: Text('프로필'),
          ),
          Container(
            child: Text('프로필'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: '프로필'),
        ],
      ),
    );
  }
}
