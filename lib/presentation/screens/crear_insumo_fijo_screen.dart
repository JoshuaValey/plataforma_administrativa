import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_fijo.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class CrearInsumoFijoScreen extends StatefulWidget {
  const CrearInsumoFijoScreen({super.key});

  @override
  State<CrearInsumoFijoScreen> createState() => _CrearInsumoFijoScreenState();
}

class _CrearInsumoFijoScreenState extends State<CrearInsumoFijoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar datos del formulario
  final _idProyectoController = TextEditingController();
  final _codigoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _numeroController = TextEditingController();
  final _modeloController = TextEditingController();
  final _capacidadController = TextEditingController();
  final _empresaController = TextEditingController();

  bool _estado = false;  // Estado del insumo (activo/inactivo)
  final bool _checked = false; // Campo opcional para indicar si está "chequeado"

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Insumo Fijo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Campo de ID del Proyecto
              TextFormField(
                controller: _idProyectoController,
                decoration: const InputDecoration(labelText: 'ID Proyecto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del proyecto';
                  }
                  return null;
                },
              ),
              // Campo de código
              TextFormField(
                controller: _codigoController,
                decoration: const InputDecoration(labelText: 'Código'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el código del insumo';
                  }
                  return null;
                },
              ),
              // Campo de nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del insumo';
                  }
                  return null;
                },
              ),
              // Campo opcional de número
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(labelText: 'Número (opcional)'),
              ),
              // Campo de modelo
              TextFormField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo (opcional)'),
              ),
              // Campo de capacidad
              TextFormField(
                controller: _capacidadController,
                decoration: const InputDecoration(labelText: 'Capacidad (opcional)'),
              ),
              // Campo de empresa
              TextFormField(
                controller: _empresaController,
                decoration: const InputDecoration(labelText: 'Empresa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de la empresa';
                  }
                  return null;
                },
              ),
              // Checkbox para el estado (activo/inactivo)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Estado (Activo)'),
                  Checkbox(
                    value: _estado,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _estado = newValue ?? false;
                      });
                    },
                  ),
                ],
              ),
              // Checkbox opcional para "chequeado"
            
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Crear un nuevo insumo fijo con los datos ingresados
                    InsumoFijo nuevoInsumo = InsumoFijo(
                      idProyecto: _idProyectoController.text,
                      codigo: _codigoController.text,
                      nombre: _nombreController.text,
                      numero: _numeroController.text,
                      modelo: _modeloController.text,
                      capacidad: _capacidadController.text,
                      empresa: _empresaController.text,
                      estado: _estado,
                      checked: _checked,
                    );
                    // aquí implementar API
                    apiService.insertDocument(jsonEncode(nuevoInsumo.toJson()), '/insumofijo/insertar');
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
    // Limpiar los controladores al salir
    _idProyectoController.dispose();
    _codigoController.dispose();
    _nombreController.dispose();
    _numeroController.dispose();
    _modeloController.dispose();
    _capacidadController.dispose();
    _empresaController.dispose();
    super.dispose();
  }
}