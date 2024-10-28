import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_fijo.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/presentation/widgets/green_button.dart';
import 'package:plataforma_administrativa/singleton.dart';

class SeleccionarInsumoFijoScreen extends StatefulWidget {
  const SeleccionarInsumoFijoScreen({super.key});
  @override
  State<SeleccionarInsumoFijoScreen> createState() => _SeleccionarInsumoFijoScreen();
}

class _SeleccionarInsumoFijoScreen extends State<SeleccionarInsumoFijoScreen> {

ApiService service = ApiService(url: Singleton.linkApiService);
Future<List<InsumoFijo>>? futureInsumosFijos;
List<InsumoFijo>? insumosFijos;
 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      if (futureInsumosFijos == null) {
        final proyecto = ModalRoute.of(context)!.settings.arguments as Proyecto;
        futureInsumosFijos = service.getInsumosFijos(proyecto,"/insumofijo/listado");
        }
  }

  @override
  Widget build(BuildContext context) {
    final proyecto = ModalRoute.of(context)!.settings.arguments as Proyecto;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insumos fijos"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<List<InsumoFijo>>(
        future: futureInsumosFijos, 
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay insumos fijos disponibles'));
          } else {
            insumosFijos ??= snapshot.data!;
            return ListView.builder(
              itemCount: insumosFijos?.length,
              itemBuilder: (context, index) {
                final insumoFijo = insumosFijos![index];
                return ListTile(
                  onTap: () { 
                    // Maneja el clic en todo el elemento de la lista
                    Navigator.pushNamed(context, Singleton.operacionSeleccionada,
                        arguments: insumoFijo);
                  },
                  title: Text(insumoFijo.nombre),
                  subtitle: Text(
                  "Codigo: ${insumoFijo.codigo}\n"
                  "Nombre: ${insumoFijo.nombre}\n"
                  "Numero: ${insumoFijo.numero ?? ''}\n"
                  "Modelo: ${insumoFijo.modelo ?? ''}\n"
                  "Capacidad: ${insumoFijo.capacidad ?? ''}\n"
                  "Empresa: ${insumoFijo.empresa}\n"
                  "Estado: ${insumoFijo.estado ? 'Activo' : ''}\n"
                )
                );
              },
            );
          }
        }
        )
    );
  }
}