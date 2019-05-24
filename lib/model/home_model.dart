import 'dart:convert';

import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel({
    this.config,
    this.bannerList,
    this.localNavList,
    this.subNavList,
    this.gridNav,
    this.salesBox,
  });

  factory HomeModel.fromJson(Map<String, dynamic> _json) {
    var localNavListJson = _json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson ?? localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = _json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson ?? bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = _json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson ?? subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      config: _json['config'] ?? ConfigModel.fromJson(_json['config']),
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      gridNav: _json['gridNav'] ?? GridNavModel.fromJson(_json['gridNav']),
      salesBox: _json['salesBox'] ?? SalesBoxModel.fromJson(_json['salesBox']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'config': json.encode(config),
      'bannerList': bannerList.map((value) => json.encode(value)).toList(),
      'localNavList': localNavList.map((value) => json.encode(value)).toList(),
      'subNavList': subNavList.map((value) => json.encode(value)).toList(),
      'gridNav': json.encode(gridNav),
      'salesBox': json.encode(salesBox),
    };
  }
}
