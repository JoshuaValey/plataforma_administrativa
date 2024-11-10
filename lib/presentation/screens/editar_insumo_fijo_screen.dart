import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_fijo.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class EditarInsumoFijoScreen extends StatefulWidget {
  const EditarInsumoFijoScreen({super.key});

  @override
  State<EditarInsumoFijoScreen> createState() => _EditarInsumoFijoScreenState();
}

class _EditarInsumoFijoScreenState extends State<EditarInsumoFijoScreen> {
  final _formKey = GlobalKey<FormState>();

   // Controladores para los campos del formulario
  final _idController= TextEditingController();
  final _idProyectoController= TextEditingController();
  final _codigoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _numeroController = TextEditingController();
  final _modeloController = TextEditingController();
  final _capacidadController = TextEditingController();
  final _empresaController = TextEditingController();
  bool _estado = false; // Inicializar _estado con un valor predeterminado

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      InsumoFijo insumoFijo = ModalRoute.of(context)!.settings.arguments as InsumoFijo;

      // Asignación de valores a los controladores y al estado
      _idController.text = insumoFijo.id!;
      _idProyectoController.text = insumoFijo.idProyecto;
      _codigoController.text = insumoFijo.codigo;
      _nombreController.text = insumoFijo.nombre;
      _numeroController.text = insumoFijo.numero ?? "";
      _modeloController.text = insumoFijo.modelo ?? "";
      _capacidadController.text = insumoFijo.capacidad ?? "";
      _empresaController.text = insumoFijo.empresa;
      _estado = insumoFijo.estado; // Asegurar que _estado tenga un valor no null
    });
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Insumo Fijo'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main_screen');
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
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
              // Checkbox para "checked"
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Editar un nuevo insumo fijo con los datos del formulario
                      InsumoFijo insumoEditado = InsumoFijo(
                      id: _idController.text,
                      idProyecto: _idProyectoController.text,
                      codigo: _codigoController.text,
                      nombre: _nombreController.text,
                      numero: _numeroController.text,
                      modelo: _modeloController.text,
                      capacidad: _capacidadController.text,
                      empresa: _empresaController.text,
                      estado: _estado,
                    );
                    // API 
                    apiService.updateDocument(jsonEncode(insumoEditado.toJson()), '/insumofijo/editar');
                    Singleton.showToast('Insumo fijo editado');
                    Navigator.pushNamed(context, '/main_insumo_fijo_screen');
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
    super.dispose();
    _nombreController.dispose();
    _codigoController.dispose();
    _nombreController.dispose();
    _numeroController.dispose();
    _modeloController.dispose();
    _capacidadController.dispose();
    _empresaController.dispose();
  }
}