import 'package:bili_app/http/core/hi_net_adapter.dart';
import 'package:bili_app/http/request/base_request.dart';

/// 测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      // 强制转换，但调用时确保类型匹配
      return HiNetResponse<T>(
        data: {
          "code": 0,
          "message": "success"
        } as T,
        statusCode: 401,
      );
    });
  }
}

