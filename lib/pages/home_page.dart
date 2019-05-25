import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/DAO/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';

const double APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _imageList = [
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558468657919&di=be97e197dadca55b0ff6937d1cde77dd&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01cc2e5947ddeca8012193a3eabef4.jpg%402o.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558468700071&di=b3dc0c7ecd60a948209356de0514ca1b&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01ce8b582439aea84a0e282ba855d9.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558468700071&di=b6cbd6335ecd82e56f070e8155d4214d&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0100b057e915da0000018c1b3911be.jpg',
  ];
  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];

  @override
  initState() {
    print('HomePage init!');
    super.initState();
    loadData();
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  loadData() {
    HomeDao.fetch().then((model) {
      setState(() => localNavList = model.localNavList);
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (ScrollNotification scrollNotification) {
                if (scrollNotification.depth == 0) {
                  // 过滤 防止 swiper 滚动干扰
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imageList.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageList[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                    child: LocalNav(
                      localNavList: localNavList,
                    ),
                  ),
                  Container(
                    height: 800,
                    child: Text('123'),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  child: Text('首页'),
                  padding: EdgeInsets.only(top: 20),
                ),
              ),
            ),
            opacity: appBarAlpha,
          )
        ],
      ),
    );
  }
}
