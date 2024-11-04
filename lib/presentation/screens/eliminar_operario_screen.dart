import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/Repository/operario.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/presentation/widgets/green_button.dart';
import 'package:plataforma_administrativa/presentation/widgets/red_button.dart';
import 'package:plataforma_administrativa/singleton.dart';

class EliminarOperarioScreen extends StatefulWidget {
  const EliminarOperarioScreen({super.key});

  @override
  State<EliminarOperarioScreen> createState() => _EliminarOperarioScreen();
}

class _EliminarOperarioScreen extends State<EliminarOperarioScreen> {

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);
  

  @override
  Widget build(BuildContext context) {
    Operario operario = ModalRoute.of(context)!.settings.arguments as Operario;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main_screen');
              },
              icon: const Icon(Icons.home))
        ],
        title: const Text('Eliminar Operario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text("Esta seguro de eliminar el operario?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RedButton(label: 'Si', onPressed: (){ 
                    apiService.deleteDocument(jsonEncode(operario.toJson()), '/operario/eliminar');
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