

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_insumo_fijo_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_insumo_variable_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_operario_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_proyecto_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/eliminar_proyecto_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/login_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/main_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/reporte_detalle_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/reporte_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/seleccionar_proyecto_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/editar_proyecto_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/main_proyecto_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/main_insumo_variable_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/seleccionar_insumo_variable_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/editar_insumo_variable_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/eliminar_insumo_variable_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/main_insumo_fijo_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/seleccionar_insumo_fijo_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/editar_insumo_fijo_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/eliminar_insumo_fijo_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/seleccionar_usuario_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/main_asignaciones_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_asignacion_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/main_operario_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/seleccionar_operario_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/editar_operario_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/eliminar_operario_screen.dart';
import 'package:plataforma_administrativa/presentation/screens/crear_usuario_screen.dart';








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
        '/seleccionar_proyecto_screen': (context) => const SeleccionarProyectoScreen(),
        '/editar_proyecto_screen': (context) => const EditarProyectoScreen(),
        '/main_proyecto_screen': (context) => const MainProyectoScreen(),
        '/eliminar_proyecto_screen': (context) => const EliminarProyectoScreen(),
        '/main_insumo_variable_screen': (context) => const MainInsumoVariableScreen(),
        '/seleccionar_insumo_variable_screen': (context) => const SeleccionarInusmoVariableScreen(),
        '/eliminar_insumo_variable_screen':(context) => const EliminarInsumoVariableScreen(),
        '/editar_insumo_variable_screen':(context) => const EditarInsumoVariableScreen(),
        '/reporte_screen': (context) => const ReporteScreen(),
        '/main_insumo_fijo_screen': (context) => const MainInsumoFijoScreen(),
        '/seleccionar_insumo_fijo_screen': (context) => const SeleccionarInsumoFijoScreen(),
        '/editar_insumo_fijo_screen':(context) => const EditarInsumoFijoScreen(),
        '/eliminar_insumo_fijo_screen':(context) => const EliminarInsumoFijoScreen(),
        '/seleccionar_usuario_screen':(context) => const SeleccionarUsuarioScreen(),
        '/main_asignaciones_screen': (context) => const MainAsignacionesScreen(),
        '/crear_asignacion_screen': (context) => const CrearAsignacionScreen(),
        '/reporte_detalle_screen': (context) => const  ReporteDetalleScreen(),
        '/main_operario_screen': (context) => const MainOperarioScreen(),
        '/seleccionar_operario_screen': (context) => const SeleccionarOperarioScreen(),
        '/editar_operario_screen': (context) => const EditarOperarioScreen(),
        '/eliminar_operario_screen': (context) => const EliminarOperarioScreen(),
        '/crear_usuario_screen': (context) => const CrearUsuarioScreen(),


      },
      home: const LoginScreen(),
    );
  }
}


