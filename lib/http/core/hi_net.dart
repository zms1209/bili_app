import 'package:bili_app/http/core/dio_adapter.dart';
import 'package:bili_app/http/core/hi_error.dart';
import 'package:bili_app/http/core/mock_adapter.dart';
import 'package:bili_app/http/request/base_request.dart';
import 'package:flutter/widgets.dart';

import 'hi_net_adapter.dart';

class HiNet {
  HiNet._();

  static HiNet? _instance;

  static HiNet? getInstance() {
    _instance ??= HiNet._();

    return _instance;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    dynamic error;

    try {
      response = await send(request);
    } on HiNetError catch(e){
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);

    var statusCode = response?.statusCode;
    switch (statusCode) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(statusCode!, result.toString(), data: result);
    }
  }
  
  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url: ${request.url()}');
    HiNetAdapter adapter = DioAdapter();
    return adapter.send<T>(request);
  }

  void printLog(log) {
    debugPrint("hi_net: ${log.toString()}");
  }
}