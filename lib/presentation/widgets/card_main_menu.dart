import 'package:flutter/material.dart';



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
            // Navegar a la pantalla indicada
            Navigator.pushNamed(context, routeName, arguments: id);
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
