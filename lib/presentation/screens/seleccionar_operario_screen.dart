import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/Repository/operario.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class SeleccionarOperarioScreen extends StatefulWidget {
  const SeleccionarOperarioScreen({super.key});
  @override
  State<SeleccionarOperarioScreen> createState() => _SeleccionarOperarioScreen();
}

class _SeleccionarOperarioScreen extends State<SeleccionarOperarioScreen> {

ApiService service = ApiService(url: Singleton.linkApiService);
Future<List<Operario>>? futureOperarios;
List<Operario>? operarios;
 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      if (futureOperarios == null) {
        final proyecto = ModalRoute.of(context)!.settings.arguments as Proyecto;
        futureOperarios = service.getOperarios(proyecto,"/operario/listado");
        }
  }

  @override
  Widget build(BuildContext context) {
    final proyecto = ModalRoute.of(context)!.settings.arguments as Proyecto;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Operarios"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<List<Operario>>(
        future: futureOperarios, 
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay operarios disponibles'));
          } else {
            operarios ??= snapshot.data!;
            return ListView.builder(
              itemCount: operarios?.length,
              itemBuilder: (context, index) {
                final operario = operarios![index];
                return ListTile(
                  onTap: () { 
                    // Maneja el clic en todo el elemento de la lista
                    Navigator.pushNamed(context, Singleton.operacionSeleccionada,
                        arguments: operario);
                  },
                  title: Text(operario.nombres),
                  subtitle: Text("Cantidad: ${operario.apellidos}"),
                );
              },
            );
          }
        }
        )
    );
  }
}