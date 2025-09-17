import 'package:bili_app/page/home_page.dart';
import 'package:bili_app/page/login_page.dart';
import 'package:bili_app/page/registration_page.dart';
import 'package:bili_app/page/video_detail_page.dart';
import 'package:flutter/material.dart';

typedef RouteChangeListener = void Function(RouteStatusInfo current, RouteStatusInfo previous);

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}

/// 获取routeStatus在页面栈中的位置
int getRouteStatusIndex(List<MaterialPage> pages, RouteStatus status) {
  for (int i = 0; i < pages.length; i++) {
    if (getStatus(pages[i]) == status) {
      return i;
    }
  }
  return -1;
}

/// 自定义路由封装，路由状态
enum RouteStatus {
  login,
  registration,
  home,
  detail,
  unknown
}

/// 获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

class RouteStatusInfo {
  final RouteStatus? status;
  final Widget? page;

  RouteStatusInfo(this.status, this.page);
}

/// 监听路由页面跳转
/// 感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;

  RouteJumpListener? _routeJump;
  final List<RouteChangeListener> _listeners = [];

  HiNavigator._();

  static HiNavigator? getInstance() {
    _instance ??= HiNavigator._();
    return _instance;
  }

  /// 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener listener) {
    _routeJump = listener;
  }

  /// 监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  /// 移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus status, {Map<String, dynamic>? args}) {
    _routeJump?.onJumpTo(status, args: args);
  }

  /// 通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> previousPages) {
    if (currentPages == previousPages) return;

    var current = RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {

  }
}

/// 抽象类供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus status, {Map<String, dynamic>? args});
}

typedef OnJumpTo = void Function(RouteStatus status, {Map<String, dynamic>? args});

/// 定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  OnJumpTo onJumpTo;

  RouteJumpListener(this.onJumpTo);
}
