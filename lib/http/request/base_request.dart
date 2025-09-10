enum HttpMethod {
  GET,
  POST,
  DELETE
}

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print('url:${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = {};

  /// 添加参数
  BaseRequest add(String k, Object? v) {
    if (v != null) {
      params[k] = v.toString();
    }
    return this;
  }

  /// 请求头参数
  Map<String, dynamic> header = {
    'course-flag': 'fa',
    'auth-token': 'ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa'
  };

  BaseRequest addHeader(String k, Object? v) {
    if (v != null) {
      header[k] = v.toString();
    }
    return this;
  }
}