import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int _currentIndex = 0;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/inventur.png',
            width: 120,
          ),
        ),
        backgroundColor: const Color.fromRGBO(48, 153, 161, 1),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 50), // Espacio entre el AppBar y el primer botón
          _buildCustomButton('Ingresar Producto', Icons.add, () {}),
          _buildCustomButton('Enviar Producto', Icons.send, () {}),
          _buildCustomButton('Gestionar Almacen', Icons.folder, () {
            Navigator.pushNamed(context, '/gestionarAlmacen');
          }),
        ],
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
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/home');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/Proceso');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/Opciones');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/gestionarAlmacen');
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

  Widget _buildCustomButton(
      String label, IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF3BB7C0),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
