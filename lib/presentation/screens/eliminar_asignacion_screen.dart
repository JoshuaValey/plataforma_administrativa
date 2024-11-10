import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/asignacion.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/presentation/widgets/green_button.dart';
import 'package:plataforma_administrativa/presentation/widgets/red_button.dart';
import 'package:plataforma_administrativa/singleton.dart';

class EliminarAsignacionScreen extends StatefulWidget {
  const EliminarAsignacionScreen({super.key});

  @override
  State<EliminarAsignacionScreen> createState() => _EliminarAsignacionScreen();
}

class _EliminarAsignacionScreen extends State<EliminarAsignacionScreen> {

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);
  

  @override
  Widget build(BuildContext context) {
    Asignacion asignacion = ModalRoute.of(context)!.settings.arguments as Asignacion;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar Asignacion'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main_screen');
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text("Esta seguro de eliminar la asignación?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RedButton(label: 'Si', onPressed: (){ 
                    apiService.deleteDocument(jsonEncode(asignacion.toJson()), '/asignacion/eliminar');
                    Navigator.pushNamed(context, '/main_screen');
                  }),
                  const SizedBox(width: 20,),
                  GreenButton(label: 'No', onPressed: (){ Navigator.pushNamed(context, '/main_screen'); }),
                  
                ],          
            ),
          ],
        ) ,
        ),
    );
  }
}