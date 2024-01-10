import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventur/models/bodega.dart';
import 'package:inventur/models/bodeguero.dart';

class Distrito {
  final String id;
  final String nombre;
  final String ubicacion;
  final String poblacion;

  Distrito({
    required this.id,
    required this.nombre,
    required this.poblacion,
    required this.ubicacion,
  });

  factory Distrito.fromJson(Map<String, dynamic> json) {
    return Distrito(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      poblacion: json['poblacion'] ?? '',
      ubicacion: json['ubicacion'] ?? '',
    );
  }

  static Future<List<Bodega>> retornarListaBodega(String nombreDistrito) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('bodegas');

    try {
      QuerySnapshot querySnapshot = await productsCollection
          .where('proveedor', isEqualTo: nombreDistrito)
          .get();

      List<Bodega> bodegas = querySnapshot.docs.map((doc) {
        return Bodega(
          nombre: doc["nombre"] ?? "",
          bodeguero: Bodeguero.fromJson(doc["idProducto"] ?? {}),
          capacidadAlmacenamiento: doc["capacidadAlmacenamiento"] ?? "",
          distrito: Distrito.fromJson(doc["distrito"] ?? ""),
          idBodega: doc["idBodega"] ?? "",
          ubicacion: doc["ubicacione"] ?? "",
        );
      }).toList();

      return bodegas;
    } catch (e) {
      print('Error al obtener productos del proveedor: $e');
      return []; // En caso de error, se devuelve una lista vacía
    }
  }
}
