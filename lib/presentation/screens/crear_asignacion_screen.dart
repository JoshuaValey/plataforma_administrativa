import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plataforma_administrativa/Repository/asignacion.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/Repository/usuario.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/presentation/widgets/green_button.dart';
import 'package:plataforma_administrativa/presentation/widgets/red_button.dart';
import 'package:plataforma_administrativa/singleton.dart';

class CrearAsignacionScreen extends StatefulWidget {
  const CrearAsignacionScreen({super.key});

  @override
  State<CrearAsignacionScreen> createState() => _CrearAsignacionScreen();
}

class _CrearAsignacionScreen extends State<CrearAsignacionScreen> {

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);
  

  @override
  Widget build(BuildContext context) {
    Usuario usuario = ModalRoute.of(context)!.settings.arguments as Usuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignar usuario a proyecto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text("Confirme la asignacion por favor", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GreenButton(label: 'Si', onPressed: (){ 
                    Asignacion nuevaAsignacion = Asignacion(idUsuario: usuario.id, idProyecto: Singleton.proyectoSeleccionado);
                    apiService.insertDocument(jsonEncode(nuevaAsignacion.toJson()), '/asignacion/insertar');
                    Navigator.pushNamed(context, '/main_screen');
                  }),
                  const SizedBox(width: 20,),
                  RedButton(label: 'No', onPressed: (){ Navigator.pushNamed(context, '/main_screen'); }),
                  
                ],          
            ),
          ],
        ) ,
        ),
    );
  }
}