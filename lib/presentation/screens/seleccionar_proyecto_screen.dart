import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';
import 'package:plataforma_administrativa/presentation/widgets/project_selection_card.dart';

class SeleccionarProyectoScreen extends StatefulWidget {
  const SeleccionarProyectoScreen({super.key});

  @override
  State<SeleccionarProyectoScreen> createState() => _SeleccionarProyectoScreenState();
}

class _SeleccionarProyectoScreenState extends State<SeleccionarProyectoScreen> {

  ApiService service = ApiService(url: Singleton.linkApiService);
  List<Proyecto>? filterProyectos;

  String query = "";

  List<Proyecto>? proyectos;

  @override
  void initState() {
    super.initState();
    loadProyectos();
  }

  Future<void> loadProyectos() async {
    try {
      proyectos = await service.getDocuments("/proyecto/listadocompleto");
      setState(() {
        filterProyectos = proyectos;
      });
    } catch (e) {
     throw Exception(e); 
    }
  }

  void updateFilter(String query) {
    setState(() {
      this.query = query;
      filterProyectos = proyectos?.where((proyecto) {
            return proyecto.name.toLowerCase().contains(query.toLowerCase()) ||
                proyecto.descripcion
                    .toLowerCase()
                    .contains(query.toLowerCase());
          }).toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: const Text('Seleccion de Proyecto'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main_screen');
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => updateFilter(value),
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filterProyectos == null
      ? const Center(child: CircularProgressIndicator())
      : filterProyectos!.isEmpty
          ? const Center(child: Text('No hay proyectos disponibles'))
          : ListView.builder(
              itemCount: filterProyectos!.length,
              itemBuilder: (BuildContext context, int index) {
                final proyectCard = filterProyectos![index];
                return ProjectSelectionCard(
                  proyecto: proyectCard,
                );
              },
            ),
                
                           ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
