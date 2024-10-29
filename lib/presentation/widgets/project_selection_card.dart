import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/singleton.dart';

class ProjectSelectionCard extends StatelessWidget {
  final Proyecto proyecto;

  const ProjectSelectionCard(
      {
        super.key,
        required this.proyecto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: InkWell(
        onTap: () {
          Singleton.proyectoSeleccionado=proyecto.id;
          Navigator.pushNamed(context, Singleton.rutaSeleccionada, arguments: proyecto);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        proyecto.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(proyecto.descripcion),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
