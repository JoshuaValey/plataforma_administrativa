import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/presentation/widgets/card_main_menu.dart';
import 'package:plataforma_administrativa/singleton.dart';


class MainProyectoScreen extends StatelessWidget {
  const MainProyectoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyectos'),
      ),
      body: Center(
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            //physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: Singleton.instance.menuItemsProyectos.map((element) {
              return CardMainMenu(
                routeName: element['routeName'],
                iconData: element['iconData'],
                label: element['label'],
                horizontalMargin: element['horizontalMargin'],
                verticalMargin: element['verticalMargin'],
              );
            }).toList()),
      ),
    );
  }
}