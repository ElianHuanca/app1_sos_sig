import 'package:dio/dio.dart';

const accessToken = 'pk.eyJ1IjoiZ3Vhc29uMDA3eGQwMCIsImEiOiJja3k2dGozZHIwejVjMnVwdmV6YW8wNHQ0In0.MxYS2Qu4BNV6uzqN6kqZiw';

class TrafficInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });


    super.onRequest(options, handler);
  }


}