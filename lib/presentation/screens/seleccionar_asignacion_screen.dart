import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/asignacion.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/Repository/usuario.dart';

class SeleccionarAsignacionScreen extends StatefulWidget {
  const SeleccionarAsignacionScreen({super.key});
  @override
  State<SeleccionarAsignacionScreen> createState() => _SeleccionarAsignacionScreen();
}

class _SeleccionarAsignacionScreen extends State<SeleccionarAsignacionScreen> {
  ApiService service = ApiService(url: Singleton.linkApiService);
  Future<List<Asignacion>>? futureAsignaciones;
  List<Asignacion>? asignaciones;

  List<Proyecto>? proyectos;
  List<Usuario>? usuarios;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureAsignaciones ??= service.getAsignaciones("/asignacion/listadocompleto");
    loadProyectos();
    loadUsuarios();
  }

  Future<String> fetchAdditionalInfo(String idUsuario, String idProyecto) async {
    if (proyectos == null || usuarios == null) {
      return 'Información no disponible';
    }
    final proyecto = proyectos!.where((p) => p.id == idProyecto).isNotEmpty
        ? proyectos!.firstWhere((p) => p.id == idProyecto)
        : null;
    final usuario = usuarios!.where((u) => u.id == idUsuario).isNotEmpty
        ? usuarios!.firstWhere((u) => u.id == idUsuario)
        : null;
    final proyectoName = proyecto?.name ?? 'Sin Nombre de Proyecto';
    final usuarioNombre = usuario?.nombreUsuario ?? 'Sin Nombre de Usuario';

    return '$proyectoName,$usuarioNombre';
  }

  Future<void> loadProyectos() async {
    try {
      proyectos = await service.getDocuments("/proyecto/listadocompleto");
      setState(() {});
    } catch (e) {
      print("Error al cargar proyectos: $e");
    }
  }

  Future<void> loadUsuarios() async {
    try {
      usuarios = await service.getUsuarios("/usuario/listado");
      setState(() {});
    } catch (e) {
      print("Error al cargar usuarios: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asignaciones"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main_screen');
              },
              icon: const Icon(Icons.home))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<List<Asignacion>>(
        future: futureAsignaciones,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay asignaciones disponibles'));
          } else {
            asignaciones ??= snapshot.data!;
            return ListView.builder(
              itemCount: asignaciones?.length,
              itemBuilder: (context, index) {
                final asignacionSeleccionada = asignaciones![index];
                return ListTile(
                  onTap: () {
                    // Maneja el clic en todo el elemento de la lista
                    Navigator.pushNamed(context, Singleton.operacionSeleccionada,
                        arguments: asignacionSeleccionada);
                  },
                  title: FutureBuilder<String>(
                  future: fetchAdditionalInfo(asignacionSeleccionada.idUsuario!, asignacionSeleccionada.idProyecto!),
                  builder: (context, snapshot) {
                    // Verifica si el Future está en espera
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Cargando..."); // Mensaje de carga mientras espera la respuesta
                    } else if (snapshot.hasError) {
                      return const Text("Error al cargar la información"); // Muestra un mensaje de error si ocurre alguno
                    } else {
                      // Divide el resultado de `fetchAdditionalInfo` en nombre del proyecto y nombre del usuario
                      final projectUserInfo = snapshot.data?.split(',') ?? [];
                      final projectName = projectUserInfo.isNotEmpty ? projectUserInfo[0] : 'Sin Nombre de Proyecto';
                      final userName = projectUserInfo.length > 1 ? projectUserInfo[1] : 'Sin Nombre de Usuario';

                      return ListTile(
                        title: Text(projectName),
                        subtitle: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Asignado: ',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            TextSpan(
                              text: userName,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      );
                    }
                  },
                ),

                );
              },
            );
          }
        },
      ),
    );
  }
}
