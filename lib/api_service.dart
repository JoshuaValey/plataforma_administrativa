import 'package:dio/dio.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';



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

  Future<void> updateDocument(String data, String enpointRoute) async {
    try {
      await _dio.put(url+enpointRoute, data: data);
    } catch (e) {
      print(e);
    }
  }

    Future<List<Proyecto>> getDocuments(String enpointRoute) async {
    try {
      
      final response = await _dio.get(url+enpointRoute);

      if(response.statusCode == 200){
        List<dynamic> body = response.data;
        List<Proyecto> proyectos = body.map((dynamic item) => Proyecto.fromJson(item)).toList();
        return proyectos;
      }
      else{
        throw Exception('Error al recibir el listado de proyectos');
      }
    
    } catch (e) {
      throw Exception(e);
    }
  }


}