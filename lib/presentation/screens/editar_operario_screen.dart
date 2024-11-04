import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/operario.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';



class EditarOperarioScreen extends StatefulWidget {
  const EditarOperarioScreen({super.key});

  @override
  State<EditarOperarioScreen> createState() => _EditarOperarioScreen();
}

class _EditarOperarioScreen extends State<EditarOperarioScreen> {
 final _formKey = GlobalKey<FormState>();
  final _documentoController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _nacionalidadController = TextEditingController();
  final _rolController = TextEditingController();
  final _sexoController = TextEditingController();
  final _jornadaController = TextEditingController();
  final _empresaController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();
  final _fechaInicioLaboresController = TextEditingController();
  final _idController = TextEditingController();
  final _idProyectoActualController = TextEditingController();

  DateTime? _fechaNacimiento;
  DateTime? _fechaInicioLabores;
  bool isChecked = false;

  ApiService apiService = ApiService(url: Singleton.linkApiService);

  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Operario operario = ModalRoute.of(context)!.settings.arguments as Operario;
      
      // Inicializar controladores y variables con datos del operario
      _idController.text = operario.id!;
      _documentoController.text = operario.documentoIdentificacion;
      _nombresController.text = operario.nombres;
      _apellidosController.text = operario.apellidos;
      _nacionalidadController.text = operario.nacionalidad;
      _rolController.text = operario.rol;
      _sexoController.text = operario.sexo;
      _jornadaController.text = operario.jornada;
      _empresaController.text = operario.empresa;
      _fechaInicioLabores = DateTime.parse(operario.fechaInicioLabores.toString().replaceAll('Z', ''));
      _fechaInicioLaboresController.text = _fechaInicioLabores.toString(); // Formatear si es necesario
      _fechaNacimiento = DateTime.parse(operario.fechaNacimiento.toString().replaceAll('Z', ''));
      _fechaNacimientoController.text = _fechaNacimiento.toString(); // Formatear si es necesario
      _idProyectoActualController.text = operario.idProyectoActual!;
      isChecked = operario.isChecked;
    });
  }


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
        title: const Text('Editar Operario'),
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
              TextFormField(
                controller: _fechaNacimientoController,
                decoration: const InputDecoration(labelText: 'Fecha de nacimiento'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _fechaNacimiento = pickedDate;
                      _fechaNacimientoController.text = _fechaNacimiento.toString();
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione la fecha de nacimiento';
                  }
                  return null;
                },
              ),
              // Campo de Fecha de Inicio de Labores
              TextFormField(
                controller: _fechaInicioLaboresController,
                decoration: const InputDecoration(labelText: 'Fecha de inicio de labores'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _fechaInicioLabores = pickedDate;
                      _fechaInicioLaboresController.text = _fechaInicioLabores.toString();
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione la fecha de inicio de labores';
                  }
                  return null;
                },
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
              // Checkbox para indicar si el operario está activo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Activo'),
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked = newValue ?? false;
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
                      id: _idController.text,
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
                      isChecked: isChecked,
                    );
                    // Aquí implementar API
                    apiService.updateDocument(jsonEncode(nuevoOperario.toJson()), '/operario/editar');
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
    super.dispose();
  }
}