import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/my_home_page.dart';
import 'package:flutter_trip/pages/my_my_page.dart';
import 'package:flutter_trip/pages/my_search_page.dart';
import 'package:flutter_trip/pages/my_travel_page.dart';

class MyTabNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyTabNav();
}

class _MyTabNav extends State<MyTabNav> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  _setSeletedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: _setSeletedIndex,
        controller: _pageController,
        children: <Widget>[
          MyHomePage(),
          MySearchPage(),
          MyTravelPage(),
          MyMyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _pageController.jumpToPage(index);
          _setSeletedIndex(index);
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('搜索'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            title: Text('旅拍'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('我的'),
          )
        ],
      ),
    );
  }
}
