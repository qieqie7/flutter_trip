import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/DAO/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/loding_container.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

const double APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  bool _isLoading = true;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;

  @override
  initState() {
    print('HomePage init!');
    _handelRefresh();
    super.initState();
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

  Future<Null> _handelRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _handelRefresh,
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
                          itemCount: bannerList.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebView(
                                          url: bannerList[index].url,
                                        ),
                                  ),
                                );
                              },
                              child: Image.network(
                                bannerList[index].icon,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                        child: LocalNav(localNavList: localNavList),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                        child: GridNav(gridNavModel: gridNavModel),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                        child: SubNav(subNavList: subNavList),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                        child: SalesBox(salesBox: salesBox),
                      ),
                      Container(
                        height: 800,
                        child: Text('123'),
                      )
                    ],
                  ),
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
      ),
    );
  }
}
