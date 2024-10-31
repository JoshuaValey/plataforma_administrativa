import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_fijo.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/presentation/widgets/green_button.dart';
import 'package:plataforma_administrativa/presentation/widgets/red_button.dart';
import 'package:plataforma_administrativa/singleton.dart';

class EliminarInsumoFijoScreen extends StatefulWidget {
  const EliminarInsumoFijoScreen({super.key});

  @override
  State<EliminarInsumoFijoScreen> createState() => _EliminarInsumoFijoScreen();
}

class _EliminarInsumoFijoScreen extends State<EliminarInsumoFijoScreen> {

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);
  

  @override
  Widget build(BuildContext context) {
    InsumoFijo insumoFijo = ModalRoute.of(context)!.settings.arguments as InsumoFijo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar Insumo Fijo'),
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
                    apiService.deleteDocument(jsonEncode(insumoFijo.toJson()), '/insumofijo/eliminar');
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