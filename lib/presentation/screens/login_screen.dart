import 'package:flutter/material.dart';
import 'package:plataforma_administrativa/presentation/widgets/green_button.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plataforma Limpia y Verde'),
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
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: const TextField(
                      decoration: InputDecoration(
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
                        
                        Navigator.pushNamed(context, '/main_screen');
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
