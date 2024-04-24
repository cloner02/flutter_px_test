import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

   Map<String, dynamic> actionlist = {
    "pokedex": {"type": "get", "url": "pokedex/kanto"},
   };

  ApiService() : _dio = Dio(BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2/',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        receiveDataWhenStatusError: true,
        )
      );



  Future<List<dynamic>> action({ String nameAction = '', dynamic data}) async {
    try {
      
      Options paramOption = Options(
        method: actionlist[nameAction]["type"].toUpperCase(),
        validateStatus: (status) {
          return status! < 600;
        },
      );

      final response = await _dio.request(actionlist[nameAction]["url"], options: paramOption, data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed the request called $nameAction');
    }
  }
}