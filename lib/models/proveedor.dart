import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventur/models/bodega.dart';
import 'package:inventur/models/producto.dart';

class Proveedor {
  final String idProveedor;
  final String nombre;
  final String cedula;
  final String correo;
  final String nombreContacto;

  Proveedor({
    required this.idProveedor,
    required this.nombre,
    required this.cedula,
    required this.correo,
    required this.nombreContacto,
  });

  // void retornarDetalleProducto(String nombre) {
  static Future<List<Producto>> retornarListaProducto(
      String nombreProveedor) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('productos');

    try {
      QuerySnapshot querySnapshot = await productsCollection
          .where('proveedor', isEqualTo: nombreProveedor)
          .get();

      List<Producto> productos = querySnapshot.docs.map((doc) {
        return Producto(
          idProducto: doc["idProducto"] ?? "",
          idCategoria: doc["idCategoria"] ?? "",
          bodega: Bodega.fromJson(doc["bodega"] ?? {}),
          cantidad: doc["cantidad"] ?? "",
          codigo: doc["codigo"] ?? "",
          descripcion: doc["descripcion"] ?? "",
          estado: doc["estado"] ?? "",
          fechaCaducidad: doc["fechaCaducidad"] ?? "",
          fechaElaboracion: doc["fechaElaboracion"] ?? "",
          nombre: doc["nombre"] ?? "",
          precio: doc["precio"] ?? "",
          proveedor: Proveedor.fromJson(doc["proveedor"] ?? {}),
        );
      }).toList();

      return productos;
    } catch (e) {
      print('Error al obtener productos del proveedor: $e');
      return []; // En caso de error, se devuelve una lista vacía
    }
  }

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      idProveedor: json['idProveedor'] ?? '',
      nombre: json['nombre'] ?? '',
      cedula: json['cedula'] ?? '',
      correo: json['correo'] ?? '',
      nombreContacto: json['nombreContacto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idProveedor': idProveedor,
      'nombre': nombre,
      'cedula': cedula,
      'correo': correo,
      'nombreContacto': nombreContacto,
    };
  }
}
