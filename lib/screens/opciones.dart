// opciones.dart

import 'package:flutter/material.dart';
import 'editopciones.dart';

class OpcionesScreen extends StatefulWidget {
  @override
  _OpcionesScreenState createState() => _OpcionesScreenState();
}

class _OpcionesScreenState extends State<OpcionesScreen> {
  String nombreDeUsuario =
      'UsuarioDemo'; // Puedes inicializar con el nombre actual
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // Imagen de perfil, puedes cargarla desde algún lugar
            ),
            SizedBox(height: 16),
            Text(
              'Nombre de Perfil: $nombreDeUsuario',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Agregar lógica para modificar el nombre de perfil
                // Puedes abrir la pantalla de edición de opciones
                _abrirPantallaEdicionOpciones();
              },
              child: Text('Modificar Nombre'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Agregar lógica para cerrar sesión
              },
              child: Text('Cerrar Sesión'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Agregar lógica para registros de documentación
              },
              child: Text('Registros de Documentación'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Color.fromRGBO(48, 153, 161, 1),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/home');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/proceso');
                break;
              case 3:
                // Ya estás en la pantalla de opciones
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse),
              label: 'Proceso',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Opciones',
            ),
          ],
        ),
      ),
    );
  }

  void _abrirPantallaEdicionOpciones() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditOpcionesScreen(currentUsername: nombreDeUsuario),
      ),
    );

    if (result != null && result is bool && result) {
      // Actualizar la interfaz o realizar otras acciones si es necesario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nombre de usuario actualizado con éxito'),
        ),
      );
      // Actualizar el nombre de usuario si es necesario
      // nombreDeUsuario = ...
    }
  }
}
