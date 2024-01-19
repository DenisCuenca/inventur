// editopciones.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditOpcionesScreen extends StatefulWidget {
  final String currentUsername;

  EditOpcionesScreen({required this.currentUsername});

  @override
  _EditOpcionesScreenState createState() => _EditOpcionesScreenState();
}

class _EditOpcionesScreenState extends State<EditOpcionesScreen> {
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.currentUsername;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Nombre de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Nuevo Nombre de Usuario',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _actualizarNombreDeUsuario();
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _actualizarNombreDeUsuario() async {
    try {
      // Obtener la instancia actual del usuario
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Actualizar el nombre de usuario en Firebase Auth
        await user.updateDisplayName(_usernameController.text);

        // Informar a la pantalla anterior que se realizaron cambios
        Navigator.pop(context, true);
      }
    } catch (e) {
      print("Error al actualizar el nombre de usuario: $e");
      // Manejar el error según tus necesidades
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar el nombre de usuario'),
        ),
      );
    }
  }
}
