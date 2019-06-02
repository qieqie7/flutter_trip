import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/my_webview.dart';

class MyGridNav extends StatelessWidget {
  final GridNavModel gridNav;

  const MyGridNav({Key key, @required this.gridNav}) : super(key: key);

  List<Widget> _buildItems(BuildContext context) {
    List<Widget> items = [];

    if (gridNav == null) return items;

    if (gridNav.hotel != null) {
      items.add(_buildItem(context, gridNav.hotel, isFirst: true));
    }

    if (gridNav.flight != null) {
      items.add(_buildItem(context, gridNav.flight));
    }

    if (gridNav.travel != null) {
      items.add(_buildItem(context, gridNav.travel));
    }
    return items;
  }

  Widget _buildItem(BuildContext context, GridNavItemModel item,
      {bool isFirst = false}) {
    List<Widget> items = [];
    items.add(_buildMainItem(context, item.mainItem));
    items.add(
      Expanded(
        child: _buildDoubleItem(context, item.item1, item.item2),
      ),
    );
    items.add(
      Expanded(
        child: _buildDoubleItem(context, item.item3, item.item4, isLast: true),
      ),
    );
    return Container(
      margin: isFirst ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          colors: [
            Color(int.parse('0xff${item.startColor}')),
            Color(int.parse('0xff${item.endColor}'))
          ],
        ),
      ),
      child: Row(
        children: items,
      ),
    );
  }

  Widget _buildMainItem(BuildContext context, CommonModel model) {
    Widget container = Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 0.8, color: Colors.white),
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.network(
            model.icon,
            height: 88,
            width: 121,
            alignment: Alignment.bottomCenter,
            fit: BoxFit.contain,
          ),
          Container(
            padding: EdgeInsets.only(top: 11),
            child: Text(
              model.title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    return _generalGestureHandle(
      context: context,
      item: model,
      child: container,
    );
  }

  Widget _buildDoubleItem(
    BuildContext context,
    CommonModel item1,
    CommonModel item2, {
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: isLast
              ? BorderSide.none
              : BorderSide(width: 0.8, color: Colors.white),
        ),
      ),
      height: 88,
      child: Column(
        children: <Widget>[
          _itemForDouble(context, item1, isFirst: true),
          _itemForDouble(context, item2),
        ],
      ),
    );
  }

  Widget _itemForDouble(
    BuildContext context,
    CommonModel item, {
    bool isFirst = false,
  }) {
    return Expanded(
      flex: 1,
      child: _generalGestureHandle(
        context: context,
        item: item,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: isFirst
                  ? BorderSide.none
                  : BorderSide(width: 0.8, color: Colors.white),
            ),
          ),
          child: Center(
            child: Text(
              item.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _generalGestureHandle({
    @required BuildContext context,
    @required CommonModel item,
    @required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyWebView(
                  url: item.url,
                  statusBarColor: item.statusBarColor,
                  title: item.title,
                  hideAppBar: item.hideAppBar,
                  // backForbid: item.backForbid,
                ),
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Column(
        children: _buildItems(context),
      ),
    );
  }
}
