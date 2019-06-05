import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/DAO/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/my_grid_nav.dart';
import 'package:flutter_trip/widget/my_loading_container.dart';
import 'package:flutter_trip/widget/my_local_nav.dart';

const double MAX_SCROLL_PIXEL = 100;

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  bool _isLoading = true;
  double _opacity = 0;

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNav;

  @override
  void initState() {
    print('home page init');
    _loadData();
    super.initState();
  }

  Future<Null> _loadData() async {
    try {
      HomeModel result = await HomeDao.fetch();
      setState(() {
        _isLoading = false;
        bannerList = result.bannerList;
        localNavList = result.localNavList;
        gridNav = result.gridNav;
      });
    } catch (error) {
      setState(() => _isLoading = false);
    }
    return null;
  }

  _handleListScroll(double offset) {
    double opacity = offset / MAX_SCROLL_PIXEL;
    if(opacity > 1) opacity = 1;
    else if(opacity < 0) opacity = 0;
    setState(() {
      _opacity = opacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyLoadingContainer(
      isLoading: _isLoading,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Color(0xfff2f2f2)),
        child: Stack(
          children: <Widget>[
            RefreshIndicator(
              onRefresh: _loadData,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if(notification.depth == 0) {
                    _handleListScroll(notification.metrics.pixels);
                  }
                  return true; // 取消通知冒泡
                },
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: 160,
                      child: Swiper(
                        autoplay:
                            bannerList.length > 0, // 解决 banner 广告在突然有值之后会快速移动
                        itemCount: bannerList.length,
                        itemBuilder: (BuildContext context, index) {
                          return Image.network(
                            bannerList[index].icon,
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: MyLocalNav(localNavList: localNavList),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: MyGridNav(
                        gridNav: gridNav,
                      ),
                    ),
                    Container(
                      height: 800,
                      child: Text('剩下的部分'),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: _opacity,
              child: Container(
                height: 80,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: Colors.white,
                child: Center(
                  child: Text(
                    '首页',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
