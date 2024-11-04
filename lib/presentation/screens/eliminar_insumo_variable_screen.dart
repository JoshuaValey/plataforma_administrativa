import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/presentation/widgets/green_button.dart';
import 'package:plataforma_administrativa/presentation/widgets/red_button.dart';
import 'package:plataforma_administrativa/singleton.dart';

class EliminarInsumoVariableScreen extends StatefulWidget {
  const EliminarInsumoVariableScreen({super.key});

  @override
  State<EliminarInsumoVariableScreen> createState() => _EliminarInsumoVariableScreen();
}

class _EliminarInsumoVariableScreen extends State<EliminarInsumoVariableScreen> {

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);
  

  @override
  Widget build(BuildContext context) {
    InsumoVariable insumoVariable = ModalRoute.of(context)!.settings.arguments as InsumoVariable;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar Insumo Variable'),
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
              child: Text("Esta seguro de eliminar el insumo?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RedButton(label: 'Si', onPressed: (){ 
                    apiService.deleteDocument(jsonEncode(insumoVariable.toJson()), '/insumovariable/eliminar');
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