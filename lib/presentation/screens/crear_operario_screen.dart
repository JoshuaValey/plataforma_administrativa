import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/operario.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';



class CrearOperarioScreen extends StatefulWidget {
  const CrearOperarioScreen({super.key});

  @override
  State<CrearOperarioScreen> createState() => _CrearOperarioScreenState();
}

class _CrearOperarioScreenState extends State<CrearOperarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _documentoController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _nacionalidadController = TextEditingController();
  final _rolController = TextEditingController();
  final _sexoController = TextEditingController();
  final _jornadaController = TextEditingController();
  final _empresaController = TextEditingController();
  final _idProyectoActualController = TextEditingController();

  DateTime? _fechaNacimiento;
  DateTime? _fechaInicioLabores;
  bool _isChecked = false; // Para indicar si el operario está activo

  // Instancia de api service. 

  ApiService apiService = ApiService(url: Singleton.linkApiService);

  // Función para seleccionar una fecha
  Future<void> _selectDate(BuildContext context, Function(DateTime) onDatePicked) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      onDatePicked(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Operario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _documentoController,
                decoration: const InputDecoration(labelText: 'Documento de Identificación'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el documento de identificación';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nombresController,
                decoration: const InputDecoration(labelText: 'Nombres'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los nombres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apellidosController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los apellidos';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nacionalidadController,
                decoration: const InputDecoration(labelText: 'Nacionalidad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la nacionalidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rolController,
                decoration: const InputDecoration(labelText: 'Rol'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el rol del operario';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sexoController,
                decoration: const InputDecoration(labelText: 'Sexo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el sexo del operario';
                  }
                  return null;
                },
              ),
              // Campo de Fecha de Nacimiento
              ListTile(
                title: Text(
                  _fechaNacimiento == null
                      ? 'Fecha de Nacimiento'
                      : 'Fecha de Nacimiento: ${_fechaNacimiento!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, (pickedDate) {
                  setState(() {
                    _fechaNacimiento = pickedDate;
                  });
                }),
              ),
              // Campo de Fecha de Inicio de Labores
              ListTile(
                title: Text(
                  _fechaInicioLabores == null
                      ? 'Fecha de Inicio de Labores'
                      : 'Fecha de Inicio: ${_fechaInicioLabores!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, (pickedDate) {
                  setState(() {
                    _fechaInicioLabores = pickedDate;
                  });
                }),
              ),
              TextFormField(
                controller: _jornadaController,
                decoration: const InputDecoration(labelText: 'Jornada'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la jornada';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _empresaController,
                decoration: const InputDecoration(labelText: 'Empresa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la empresa';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idProyectoActualController,
                decoration: const InputDecoration(labelText: 'ID del Proyecto Actual'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del proyecto actual';
                  }
                  return null;
                },
              ),
              // Checkbox para indicar si el operario está activo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Activo'),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isChecked = newValue ?? false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Operario nuevoOperario = Operario(
                      documentoIdentificacion: _documentoController.text,
                      nombres: _nombresController.text,
                      apellidos: _apellidosController.text,
                      nacionalidad: _nacionalidadController.text,
                      rol: _rolController.text,
                      sexo: _sexoController.text,
                      fechaNacimiento: _fechaNacimiento!,
                      fechaInicioLabores: _fechaInicioLabores!,
                      jornada: _jornadaController.text,
                      empresa: _empresaController.text,
                      idProyectoActual: _idProyectoActualController.text,
                      isChecked: _isChecked,
                    );
                    // Aquí implementar API
                    apiService.insertDocument(jsonEncode(nuevoOperario.toJson()), '/operario/insertar');
                    print('Nuevo operario creado: ${nuevoOperario.nombres}');
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
    _documentoController.dispose();
    _nombresController.dispose();
    _apellidosController.dispose();
    _nacionalidadController.dispose();
    _rolController.dispose();
    _sexoController.dispose();
    _jornadaController.dispose();
    _empresaController.dispose();
    _idProyectoActualController.dispose();
    super.dispose();
  }
}