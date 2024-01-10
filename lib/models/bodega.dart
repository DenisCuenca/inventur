import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventur/models/bodeguero.dart';
import 'package:inventur/models/distrito.dart';
import 'package:inventur/models/producto.dart';
import 'package:inventur/models/proveedor.dart';

class Bodega {
  final String idBodega;
  final String nombre;
  final String ubicacion;
  int capacidadAlmacenamiento;
  final Bodeguero bodeguero;
  final Distrito distrito;

  Bodega({
    required this.idBodega,
    required this.nombre,
    required this.ubicacion,
    required this.capacidadAlmacenamiento,
    required this.bodeguero,
    required this.distrito,
  });

  static var can = 0;

  factory Bodega.fromJson(Map<String, dynamic> json) {
    return Bodega(
      idBodega: json['idBodega'] ?? '',
      nombre: json['nombre'] ?? '',
      ubicacion: json['ubicacion'] ?? '',
      capacidadAlmacenamiento: json['capacidadAlmacenamiento'] ?? 0,
      bodeguero: Bodeguero.fromJson(json['bodeguero'] ??
          {}), // Asume que tienes un método fromJson en la clase Bodeguero
      distrito: Distrito.fromJson(json['distrito'] ??
          {}), // Asume que tienes un método fromJson en la clase Bodeguero
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBodega': idBodega,
      'nombre': nombre,
      'ubicacion': ubicacion,
      'capacidadAlmacenamiento': capacidadAlmacenamiento,
      'bodeguero': bodeguero
          .toJson(), // Asume que tienes un método toJson en la clase Bodeguero
    };
  }

  Future<List<Producto>> retornarListaProducto(String nombreProveedor) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('productos');

    try {
      QuerySnapshot querySnapshot = await productsCollection
          .where('proveedor.nombre', isEqualTo: nombreProveedor)
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

  bool comprovarExistencias(Producto producto) {
    if (producto.cantidad == 0) {
      return true;
    }
    return false;
  }

  Future<int> retornarStock(String nombreProveedor) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('productos');

    try {
      QuerySnapshot querySnapshot =
          await productsCollection.where('idBodega', isEqualTo: idBodega).get();

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

      productos.forEach((element) {
        can + element.cantidad;
      });

      return can;
    } catch (e) {
      print('Error al obtener productos del proveedor: $e');
      return 0; // En caso de error, se devuelve una lista vacía
    }
  }

  void actualizarStock() {
    this.capacidadAlmacenamiento = can;
  }

  void generarReporte(Producto producto) {
    print('Generando reporte para ${producto.nombre}');
    print('Descripción: ${producto.descripcion}');
    print('Cantidad en stock: ${producto.cantidad}');
  }

  void enviarConfirmacion(
    Function callback,
  ) {
    callback();
  }
}
