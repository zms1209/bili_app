import 'dart:convert';

import 'package:bili_app/db/hi_cache.dart';
import 'package:bili_app/http/core/hi_error.dart';
import 'package:bili_app/http/core/hi_net.dart';
import 'package:bili_app/http/dao/login_dao.dart';
import 'package:bili_app/http/request/test_request.dart';
import 'package:bili_app/model/video_modal.dart';
import 'package:bili_app/page/home_page.dart';
import 'package:bili_app/page/login_page.dart';
import 'package:bili_app/page/registration_page.dart';
import 'package:bili_app/page/video_detail_page.dart';
import 'package:bili_app/util/color.dart';
import 'package:flutter/material.dart';

import 'http/request/notice_request.dart';
import 'model/owner.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({super.key});

  @override
  State<BiliApp> createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _biliRouteDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    var widget = Router(
      routerDelegate: _biliRouteDelegate
    );

    return MaterialApp(
      home: widget
    );
  }
}


class BiliRouteDelegate extends RouterDelegate<BiliRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];
  VideoModel? videoModel;
  BiliRoutePath? path;

  @override
  Widget build(BuildContext context) {
    pages = [
      pageWrap(HomePage(
        onJumpToDetail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        }
      )),
      if (videoModel != null) pageWrap(VideoDetailPage(video: videoModel))
    ];

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        // 是否可以返回
        if (!route.didPop(result)) {
          return false;
        }
        // pages.removeLast();
        // notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {
    path = configuration;
  }
  
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}

// 创建页面
pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}