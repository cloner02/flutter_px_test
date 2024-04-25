import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

   Map<String, dynamic> actionlist = {
    "pokedex": {"type": "get", "path": "pokedex/:region"},
   };

  ApiService() : _dio = Dio(BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2/',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        receiveDataWhenStatusError: true,
        )
      );


  String replaceParametersValueWithPath({required String path, Map<String,String>? parameters}) {
    parameters?.forEach((key, value) {
      path = path.replaceAll(':$key', value);
    });

    return path;
  }

  Future<Map<String,dynamic>> action({ String nameAction = '', Map<String,String>? parameters, dynamic data}) async {
    try {
      
      Options paramOption = Options(
        method: actionlist[nameAction]["type"].toUpperCase(),
        validateStatus: (status) {
          return status! < 600;
        },
      );

      final response = await _dio.request(
        replaceParametersValueWithPath(path: actionlist[nameAction]["path"],parameters:  parameters), 
        options: paramOption, 
        data: data
      );

      return Future.value(response.data);
    } catch (e) {
      throw Exception('Failed the request called $nameAction');
    }
  }
}