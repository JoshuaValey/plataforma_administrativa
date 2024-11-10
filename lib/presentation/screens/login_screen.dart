import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/Repository/usuario.dart';
import 'package:plataforma_administrativa/api_service.dart';
import 'package:plataforma_administrativa/presentation/widgets/green_button.dart';
import 'package:plataforma_administrativa/singleton.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para los campos de texto
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Limpiar los controladores cuando el widget se destruya
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService(url: Singleton.linkApiService);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plataforma Limpia y Verde'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          color: Colors.white,
          onPressed: () {
            // Acción al presionar el icono de logout
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage('assets/lyv.png'),
                    height: 300,
                    width: 300,
                  ),
                  const SizedBox(height: 50),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextField(
                      controller: _usernameController, // Asignar controlador
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextField(
                      controller: _passwordController, // Asignar controlador
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GreenButton(
                    label: 'Iniciar Sesión',
                    onPressed: () {
                      // Obtener los valores de los campos de texto
                     
                      String usuario  =  _usernameController.text;
                      String contrasenia = _passwordController.text;

                      if (usuario.isEmpty || contrasenia.isEmpty) {
                        // Validación simple
                        //Singleton.showToast('Por favor ingrese usuario y contraseña');
                        return;
                      }

                      Usuario usuarioLogin = Usuario(
                      nombreUsuario: usuario,
                      contrasenia: contrasenia,
                      rol: "Admin",
                      );

                      // Llamar a la API o hacer alguna acción con los datos
                      apiService.login(usuarioLogin, '/usuario/iniciarsesion').then((response) {
                        if (response.rol == "Admin") {
                          //Singleton.showToast('Bienvenido');
                          Navigator.pushNamed(context, '/main_screen');
                        } else {
                          //Singleton.showToast('Credenciales incorrectas');
                        }
                      }).catchError((e) {
                        //Singleton.showToast('Error al intentar iniciar sesión');
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
