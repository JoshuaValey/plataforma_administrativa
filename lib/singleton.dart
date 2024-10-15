import 'package:flutter/material.dart';

class Singleton {
  // Instancia única de la clase
  static final Singleton _instance = Singleton._internal();

  // Constructor privado
  Singleton._internal();

  // Método estático para acceder a la instancia
  static Singleton get instance => _instance;
  
  //Strings
  static String newProjectEndpoint = "/proyecto/insertar";
  static String newOperarioEndpoint = "/operario/insertar";
  static String newInsumoFijoEndpoint = "/insumofijo/insertar";
  static String newInsumoVariableEndpoint = "/insumovariable/insertar";
  static String linkApiService = "https://profound-vigorously-cobra.ngrok-free.app";
  
  //Crear menu de pagina "Inicio""
  static double horizontalMarginLittleCards = 10.0;
  static double verticalMarginLittleCards = 10.0;
  List<Map<String, dynamic>> menuItems = [
    {
      'routeName': '/crear_operario_screen',
      'iconData': Icons.person,
      'label': 'Nuevo Operario',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/crear_proyecto_screen',
      'iconData': Icons.inventory_sharp,
      'label': 'Nuevo Proyecto',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
     {
      'routeName': '/crear_insumo_fijo_screen',
      'iconData': Icons.cleaning_services,
      'label': 'Nuevo insumo ID',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/crear_insumo_variable_screen',
      'iconData': Icons.cleaning_services_rounded,
      'label': 'Nuevo insumo',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
  ];
  
  }