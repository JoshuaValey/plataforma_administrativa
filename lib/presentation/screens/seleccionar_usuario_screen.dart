import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/Repository/usuario.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class SeleccionarUsuarioScreen extends StatefulWidget {
  const SeleccionarUsuarioScreen({super.key});
  @override
  State<SeleccionarUsuarioScreen> createState() => _SeleccionarUsuarioScreen();
}

class _SeleccionarUsuarioScreen extends State<SeleccionarUsuarioScreen> {

ApiService service = ApiService(url: Singleton.linkApiService);
Future<List<Usuario>>? futureUsuarios;
List<Usuario>? usuarios;
 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      futureUsuarios ??= service.getUsuarios("/usuario/listado");
  }

  @override
  Widget build(BuildContext context) {
    final proyecto = ModalRoute.of(context)!.settings.arguments as Proyecto;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monitores"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main_screen');
              },
              icon: const Icon(Icons.home))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<List<Usuario>>(
        future: futureUsuarios, 
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
            usuarios ??= snapshot.data!;
            return ListView.builder(
              itemCount: usuarios?.length,
              itemBuilder: (context, index) {
                final insumoVariable = usuarios![index];
                return ListTile(
                  onTap: () { 
                    // Maneja el clic en todo el elemento de la lista
                    Navigator.pushNamed(context, Singleton.operacionSeleccionada,
                        arguments: insumoVariable);
                  },
                  title: Text(insumoVariable.nombreUsuario),
                );
              },
            );
          }
        }
        )
    );
  }
}