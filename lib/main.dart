import 'dart:convert';

import 'package:bili_app/db/hi_cache.dart';
import 'package:bili_app/http/core/hi_error.dart';
import 'package:bili_app/http/core/hi_net.dart';
import 'package:bili_app/http/dao/login_dao.dart';
import 'package:bili_app/http/request/test_request.dart';
import 'package:bili_app/model/video_modal.dart';
import 'package:bili_app/navigator/hi_navigator.dart';
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
  final BiliRouteDelegate _biliRouteDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache?>(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache?> snapshot) {
        // 加载中/首页
        var widget = snapshot.connectionState == ConnectionState.done ?
          Router(
              routerDelegate: _biliRouteDelegate
          )
          :
          Scaffold(body: Center(child: CircularProgressIndicator(),),);
        return MaterialApp(
          home: widget,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        );
      },
    );
  }
}


class BiliRouteDelegate extends RouterDelegate<BiliRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getRouteStatusIndex(pages, routeStatus);
    List<MaterialPage> tempPages = [];
    if (index != -1) {
      // 要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      // 跳转首页时将栈中其他页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(HomePage(
        onJumpToDetail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        }
      ));
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(video: videoModel));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage(
        onJumpToLogin: () {
          _routeStatus = RouteStatus.login;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    // 重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    pages = tempPages;

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

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {
  }
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}

