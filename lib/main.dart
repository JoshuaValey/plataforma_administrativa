

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_insumo_fijo_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_insumo_variable_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_operario_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_proyecto_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/login_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
       initialRoute: '/',
      routes: {
        '/main_screen': (context) => const MainScreen(),
        '/crear_proyecto_screen': (context) => const CrearProyectoScreen(),
        '/crear_operario_screen': (context) => const CrearOperarioScreen(),
        '/crear_insumo_fijo_screen': (context) => const CrearInsumoFijoScreen(),
        '/crear_insumo_variable_screen': (context) => const CrearInsumoVariableScreen(),
      },
      home: const LoginScreen(),
    );
  }
}


