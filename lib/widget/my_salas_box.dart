import 'package:flutter/material.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class MySalasBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const MySalasBox({Key key, this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xfff2f2f2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.network(
                  salesBox.icon,
                  height: 15,
                  fit: BoxFit.fill,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Color(0xffff4e63), Color(0xfff6cc9)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
