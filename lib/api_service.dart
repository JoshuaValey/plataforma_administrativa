import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plataforma_administrativa/Repository/asignacion.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/Repository/insumo_fijo.dart';
import 'package:plataforma_administrativa/Repository/operario.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/Repository/usuario.dart';


import 'package:plataforma_administrativa/Repository/reporte.dart';

class ApiService {
  final String url;
  final _dio = Dio();

  ApiService({required this.url});

  //usar dio para un método post que mande a la api un json para insertar datos, no traer.
  Future<void> insertDocument(String data, String enpointRoute) async {
    try {
      await _dio.post(url + enpointRoute, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateDocument(String data, String enpointRoute) async {
    try {
      await _dio.put(url + enpointRoute, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteDocument(String data, String enpointRoute) async {
    try {
      await _dio.delete(url + enpointRoute, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Proyecto>> getDocuments(String enpointRoute) async {
    try {
      final response = await _dio.get(url + enpointRoute);

      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        List<Proyecto> proyectos =
            body.map((dynamic item) => Proyecto.fromJson(item)).toList();
        return proyectos;
      } else {
        throw Exception('Error al recibir el listado de proyectos');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

    Future<List<Asignacion>> getAsignaciones(String enpointRoute) async {
    try {
      final response = await _dio.get(url + enpointRoute);

      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        List<Asignacion> asignaciones =
            body.map((dynamic item) => Asignacion.fromJson(item)).toList();
        return asignaciones;
      } else {
        throw Exception('Error al recibir el listado de asignaciones');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<InsumoVariable>> getInsumosVariables(
      Proyecto data, String enpointRoute) async {
    try {
      final response = await _dio.post(url + enpointRoute,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
          }));

      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        List<InsumoVariable> insumosVariables =
            body.map((dynamic item) => InsumoVariable.fromJson(item)).toList();
        return insumosVariables;
      } else {
        throw Exception('Error al recibir el listado de insumos');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<InsumoFijo>> getInsumosFijos(Proyecto data,String enpointRoute) async {
    try {
      
      final response = await _dio.post(url+enpointRoute, data:data, options: Options(headers: {"Content-Type":"application/json",}));

      if(response.statusCode == 200){
        List<dynamic> body = response.data;
        List<InsumoFijo> insumosFijos = body.map((dynamic item) => InsumoFijo.fromJson(item)).toList();
        return insumosFijos;
      }
      else{
        throw Exception('Error al recibir el listado de insumos');
      }
    

}
catch (e) {
      throw Exception(e);
    }

  }
  
    // Traer todos los
  Future<List<Reporte>> getReportesCompletos() async {
    //Dame el codigo de una peticion post
    try {
      final response =
          await _dio.post('$url/reporte/listadocompleto?cantidad=0',
              data: null,
              options: Options(headers: {
                "Content-Type": "application/json",
              }));
      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        List<Reporte> reportes =
            body.map((dynamic item) => Reporte.fromJson(item)).toList();
        return reportes;
      } else {
        throw Exception('Error al recibir el listado de reportes');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

      Future<List<Usuario>> getUsuarios(String enpointRoute) async {
    try {
      
      final response = await _dio.get(url+enpointRoute);

      if(response.statusCode == 200){
        List<dynamic> body = response.data;
        List<Usuario> usuarios = body.map((dynamic item) => Usuario.fromJson(item)).toList();
        return usuarios;
      }
      else{
        throw Exception('Error al recibir el listado de usuarios');
      }
    
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<List<Reporte>> getReporteFiltrado(ReporteFiltro data) async {
    try {
      final response = await _dio.post('$url/reporte/listadolimitado',
          data: jsonEncode(data.toJson()),
          options: Options(headers: {
            "Content-Type": "application/json",
          }));
      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        List<Reporte> reportes =
            body.map((dynamic item) => Reporte.fromJson(item)).toList();
        return reportes;
      } else {
        throw Exception('Error al recibir el listado de reportes');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  

  Future<List<Operario>> getOperarios(
      Proyecto data, String enpointRoute) async {
    try {
      final response = await _dio.post(url + enpointRoute,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
          }));

      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        List<Operario> operarios =
            body.map((dynamic item) => Operario.fromJson(item)).toList();
        return operarios;
      } else {
        throw Exception('Error al recibir el listado de insumos');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  
  }