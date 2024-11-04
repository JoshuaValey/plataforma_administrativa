import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class SeleccionarInusmoVariableScreen extends StatefulWidget {
  const SeleccionarInusmoVariableScreen({super.key});
  @override
  State<SeleccionarInusmoVariableScreen> createState() => _SeleccionarInusmoVariableScreen();
}

class _SeleccionarInusmoVariableScreen extends State<SeleccionarInusmoVariableScreen> {

ApiService service = ApiService(url: Singleton.linkApiService);
Future<List<InsumoVariable>>? futureInsumosVariables;
List<InsumoVariable>? insumosVariables;
 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      if (futureInsumosVariables == null) {
        final proyecto = ModalRoute.of(context)!.settings.arguments as Proyecto;
        futureInsumosVariables = service.getInsumosVariables(proyecto,"/insumovariable/listado");
        }
  }

  @override
  Widget build(BuildContext context) {
    final proyecto = ModalRoute.of(context)!.settings.arguments as Proyecto;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insumos variables"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<List<InsumoVariable>>(
        future: futureInsumosVariables, 
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay insumos variables disponibles'));
          } else {
            insumosVariables ??= snapshot.data!;
            return ListView.builder(
              itemCount: insumosVariables?.length,
              itemBuilder: (context, index) {
                final insumoVariable = insumosVariables![index];
                return ListTile(
                  onTap: () { 
                    // Maneja el clic en todo el elemento de la lista
                    Navigator.pushNamed(context, Singleton.operacionSeleccionada,
                        arguments: insumoVariable);
                  },
                  title: Text(insumoVariable.nombre),
                  subtitle: Text("Cantidad: ${insumoVariable.cantidad}"),
                );
              },
            );
          }
        }
        )
    );
  }
}