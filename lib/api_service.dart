import 'package:dio/dio.dart';



class ApiService {
  final String url;
  final _dio = Dio();

  ApiService({required this.url});


  //usar dio para un método post que mande a la api un json para insertar datos, no traer. 
  Future<void> insertDocument(String data, String enpointRoute) async {
    try {
      await _dio.post(url+enpointRoute, data: data);
    } catch (e) {
      print(e);
    }
  }


}