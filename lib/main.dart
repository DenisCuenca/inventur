import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventur/models/proveedor.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addDocument() async {
    // Reference to a Firestore collection
    CollectionReference collection = firestore.collection('proveedores');

    // Add a document to the collection
    Proveedor quit = Proveedor(
        idProveedor: "110001",
        nombre: "Quituizaca Prov",
        cedula: "110001",
        correo: "quituizaca@gmail.com",
        nombreContacto: "nombreContactotesting");

    try {
      await collection.doc(quit.idProveedor).set(quit.toJson());
      print('Supplier added successfully');
    } catch (e) {
      print('Error adding supplier: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Document Storage'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              addDocument(); // Call the function to add a document
            },
            child: Text('Add Document'),
          ),
        ),
      ),
    );
  }
}
