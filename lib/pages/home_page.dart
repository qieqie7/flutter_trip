import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            // Container(
            //   height: 160,
            //   child: Swiper(
            //     itemCount: 2,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Image.network('src');
            //     },
            //     pagination: SwiperPagination(),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
