import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class CrearInsumoVariableScreen extends StatefulWidget {
  const CrearInsumoVariableScreen({super.key});

  @override
  State<CrearInsumoVariableScreen> createState() => _CrearInsumoVariableScreenState();
}

class _CrearInsumoVariableScreenState extends State<CrearInsumoVariableScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos del formulario
  final _idController = TextEditingController();
  final _idProyectoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _cantidadController = TextEditingController();

  final bool _checked = false; // Campo booleano para "checked"

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Insumo Variable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Campo de ID del Insumo
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID del Insumo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del insumo';
                  }
                  return null;
                },
              ),
              // Campo de ID del Proyecto
              TextFormField(
                controller: _idProyectoController,
                decoration: const InputDecoration(labelText: 'ID del Proyecto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del proyecto';
                  }
                  return null;
                },
              ),
              // Campo de Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del Insumo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del insumo';
                  }
                  return null;
                },
              ),
              // Campo de Cantidad
              TextFormField(
                controller: _cantidadController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la cantidad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              // Checkbox para "checked"
             
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Crear un nuevo insumo variable con los datos del formulario
                    InsumoVariable nuevoInsumo = InsumoVariable(
                      id: _idController.text,
                      idProyecto: _idProyectoController.text,
                      nombre: _nombreController.text,
                      cantidad: int.parse(_cantidadController.text),
                      checked: _checked,
                    );
                    // API 
                    apiService.insertDocument(jsonEncode(nuevoInsumo.toJson()), '/insumovariable/insertar');
                    print('Nuevo insumo creado: ${nuevoInsumo.nombre}');
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Limpiar los controladores cuando el widget se destruye
    _idController.dispose();
    _idProyectoController.dispose();
    _nombreController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }
}