import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final List _imageList = [
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558468657919&di=be97e197dadca55b0ff6937d1cde77dd&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01cc2e5947ddeca8012193a3eabef4.jpg%402o.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558468700071&di=b3dc0c7ecd60a948209356de0514ca1b&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01ce8b582439aea84a0e282ba855d9.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558468700071&di=b6cbd6335ecd82e56f070e8155d4214d&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0100b057e915da0000018c1b3911be.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 160,
          child: Swiper(
            autoplay: true,
            itemCount: _imageList.length,
            itemBuilder: (BuildContext context, index) {
              return Image.network(_imageList[index], fit: BoxFit.fill,);
            },
            pagination: SwiperPagination(),
          ),
        ),
        Container(
          height: 800,
          child: Text('剩下的部分'),
        ),
      ],
    );
  }
}
