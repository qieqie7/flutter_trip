import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/my_webview.dart';

class MyLocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const MyLocalNav({
    Key key,
    @required this.localNavList,
  }) : super(key: key);

  Widget _buildNavItem(BuildContext context, CommonModel item) {
    // 定个宽
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyWebView(
                  url: item.url,
                  statusBarColor: item.statusBarColor,
                  hideAppBar: item.hideAppBar,
                ),
          ),
        );
      },
      child: SizedBox(
        width: 55,
        child: Column(
          children: <Widget>[
            Image.network(
              item.icon,
              width: 32,
              height: 32,
            ),
            Text(
              item.title,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: localNavList != null
            ? localNavList.map((item) {
                return _buildNavItem(context, item);
              }).toList()
            : null,
      ),
    );
  }
}
