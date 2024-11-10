import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/insumo_variable.dart';
import 'package:plataforma_administrativa/Repository/proyecto.dart';
import 'package:plataforma_administrativa/Repository/usuario.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/singleton.dart';

class CrearUsuarioScreen extends StatefulWidget {
  const CrearUsuarioScreen({super.key});

  @override
  State<CrearUsuarioScreen> createState() => _CrearUsuarioScreen();
}

class _CrearUsuarioScreen extends State<CrearUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos del formulario
  final _nombreUsuarioController = TextEditingController();
  final _contraseniaController = TextEditingController();
  
  // Variable para el rol seleccionado
  String? _rolSeleccionado;

  // Instancia de api service
  ApiService apiService = ApiService(url: Singleton.linkApiService);

  // Opciones de roles
  final List<String> _roles = ['Admin', 'Monitor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Campo de Nombre
              TextFormField(
                controller: _nombreUsuarioController,
                decoration: const InputDecoration(labelText: 'Nombre del Usuario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del usuario';
                  }
                  return null;
                },
              ),
              // Campo de Contraseña
              TextFormField(
                controller: _contraseniaController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  return null;
                },
              ),
              // Dropdown para seleccionar el rol
              DropdownButtonFormField<String>(
                value: _rolSeleccionado,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: _roles.map((String rol) {
                  return DropdownMenuItem<String>(
                    value: rol,
                    child: Text(rol),
                  );
                }).toList(),
                onChanged: (String? nuevoRol) {
                  setState(() {
                    _rolSeleccionado = nuevoRol;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un rol';
                  }
                  return null;
                },
              ),
              // Checkbox para "checked"
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Crear un nuevo usuario con los datos del formulario
                    Usuario nuevoUsuario = Usuario(
                      nombreUsuario: _nombreUsuarioController.text,
                      contrasenia: _contraseniaController.text,
                      rol: _rolSeleccionado ?? '',
                    );
                    // API 
                    apiService.insertDocument(jsonEncode(nuevoUsuario.toJson()), '/usuario/registrar');
                    print('Nuevo usuario creado: ${nuevoUsuario.nombreUsuario}');
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
    _nombreUsuarioController.dispose();
    _contraseniaController.dispose();
    super.dispose();
  }
}