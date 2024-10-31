import 'dart:ui';

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
  static String linkApiService = "https://serviciolimpiaverde-bjb2c2g2a3gggggv.canadacentral-01.azurewebsites.net";
  static String rutaSeleccionada = "";
  static String operacionSeleccionada = "";
  static String? proyectoSeleccionado = "";
  
  //Crear menu de pagina "Inicio""
  static double horizontalMarginLittleCards = 10.0;
  static double verticalMarginLittleCards = 10.0;

  List<Map<String, dynamic>> menuItems = [
    {
      'routeName': '/crear_operario_screen',
      'iconData': Icons.person,
      'label': 'Operarios',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/main_proyecto_screen',
      'iconData': Icons.inventory_sharp,
      'label': 'Proyectos',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
     {
      'routeName': '/main_insumo_fijo_screen',
      'iconData': Icons.airport_shuttle,
      'label': 'Insumos fijos',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/main_insumo_variable_screen',
      'iconData': Icons.cleaning_services_rounded,
      'label': 'Insumos variables',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/main_asignaciones_screen',
      'iconData': Icons.assignment_ind,
      'label': 'Asignaciones Monitores',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
        {
      'routeName': '/reporte_screen',
      'iconData': Icons.checklist_outlined,
      'label': 'Reportes',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
   
  ];

  List<Map<String, dynamic>> menuItemsProyectos = [
    {
      'routeName': '/crear_proyecto_screen',
      'iconData': Icons.add,
      'label': 'Nuevo Proyecto',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.edit,
      'label': 'Editar Proyecto',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.delete,
      'label': 'Eliminar Proyecto',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
  ];

    List<Map<String, dynamic>> menuItemsInsumosVariables = [
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.add,
      'label': 'Nuevo Insumo Variable',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.edit,
      'label': 'Editar Insumo Variable',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.delete,
      'label': 'Eliminar Insumo Variable',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
  ];

List<Map<String, dynamic>> menuItemsCopia = [
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
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.inventory_2_outlined,
      'label': 'Editar Proyecto',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
  ];
  
  List<Map<String, dynamic>> menuItemsInsumosFijos = [
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.add,
      'label': 'Nuevo Insumo Fijo',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.edit,
      'label': 'Editar Insumo Fijo',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.delete,
      'label': 'Eliminar Insumo Fijo',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
  ];

  List<Map<String, dynamic>> menuItemsAsignaciones = [
    {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.add,
      'label': 'Asignar usuario a proyecto',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },
   /* {
      'routeName': '/seleccionar_proyecto_screen',
      'iconData': Icons.edit,
      'label': 'Desasignar usuario a proyecto',
      'horizontalMargin': horizontalMarginLittleCards,
      'verticalMargin': verticalMarginLittleCards,
    },*/
  ];
  }