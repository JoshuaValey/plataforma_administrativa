import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/singleton.dart';



class CardMainMenu extends StatelessWidget {
  final String? id; // Identificador opcional para enviar id de elemento a otra pantalla. 
  final String routeName; // Ruta a la que navegar
  final IconData iconData; // Ícono a mostrar
  final String label; // Texto a mostrar
  final double horizontalMargin; // Margen horizontal
  final double verticalMargin; // Margen vertical

  const CardMainMenu(
      {super.key,
      this.id,
      required this.routeName,
      required this.iconData,
      required this.label,
      required this.horizontalMargin,
      required this.verticalMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        child: InkWell(
          onTap: () {
              switch(label){
                case 'Editar Proyecto':
                  Singleton.rutaSeleccionada ="/editar_proyecto_screen";
                break;
                case 'Eliminar Proyecto':
                  Singleton.rutaSeleccionada ="/eliminar_proyecto_screen";
                  break;
                case 'Nuevo Insumo Variable':
                  Singleton.rutaSeleccionada ="/crear_insumo_variable_screen";
                break;
                case 'Editar Insumo Variable': 
                  Singleton.rutaSeleccionada ="/seleccionar_insumo_variable_screen";
                  Singleton.operacionSeleccionada = "/editar_insumo_variable_screen";
                break;
                case 'Eliminar Insumo Variable': 
                  Singleton.rutaSeleccionada ="/seleccionar_insumo_variable_screen";
                  Singleton.operacionSeleccionada = "/eliminar_insumo_variable_screen";
                break;
                case 'Nuevo Insumo Fijo':
                  Singleton.rutaSeleccionada ="/crear_insumo_fijo_screen";
                break;
                case 'Editar Insumo Fijo': 
                  Singleton.rutaSeleccionada ="/seleccionar_insumo_fijo_screen";
                  Singleton.operacionSeleccionada = "/editar_insumo_fijo_screen";
                break;
                case 'Eliminar Insumo Fijo': 
                  Singleton.rutaSeleccionada ="/seleccionar_insumo_fijo_screen";
                  Singleton.operacionSeleccionada = "/eliminar_insumo_fijo_screen";
                break;
                case 'Asignar usuario a proyecto': 
                  Singleton.rutaSeleccionada ="/seleccionar_usuario_screen";
                  Singleton.operacionSeleccionada = "/crear_asignacion_screen";
                break;
                case 'Desasignar usuario a proyecto': 
                  Singleton.rutaSeleccionada ="/seleccionar_asignacion_screen";
                  Singleton.operacionSeleccionada = "/eliminar_asignacion_screen";
                break;
                case 'Nuevo Operario':
                  Singleton.rutaSeleccionada ="/crear_operario_screen";
                break;
                case 'Editar Operario': 
                  Singleton.rutaSeleccionada ="/seleccionar_operario_screen";
                  Singleton.operacionSeleccionada = "/editar_operario_screen";
                break;
                case 'Eliminar Operario': 
                  Singleton.rutaSeleccionada ="/seleccionar_operario_screen";
                  Singleton.operacionSeleccionada = "/eliminar_operario_screen";
                break;
                default:
                break;
              }
            // Navegar a la pantalla indicada
            Navigator.pushNamed(context, routeName, arguments: id,);
          },
          child: Card(
            elevation: 10.0,
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(iconData,
                      size: 80, color: Colors.black), // Ícono proporcionado
                  const SizedBox(
                      height: 10), // Espacio entre el ícono y el texto
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // Texto proporcionado
                ],
              ),
            ),
          ),
        ),
      );
  }
}
