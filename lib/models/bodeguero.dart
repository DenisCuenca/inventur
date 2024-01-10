import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventur/models/bodega.dart';
import 'package:inventur/models/distrito.dart';
import 'package:inventur/models/producto.dart';
import 'package:inventur/models/proveedor.dart';

class Bodeguero {
  final String idBodeguero;
  final String nombre;
  final String apellido;
  final int edad;
  final String cedula;
  final String correo;

  Bodeguero({
    required this.apellido,
    required this.nombre,
    required this.idBodeguero,
    required this.edad,
    required this.cedula,
    required this.correo,
  });

  factory Bodeguero.fromJson(Map<String, dynamic> json) {
    return Bodeguero(
      idBodeguero: json['idBodeguero'] ?? '',
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      edad: json['edad'] ?? 0,
      cedula: json['cedula'] ?? '',
      correo: json['correo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBodeguero': idBodeguero,
      'nombre': nombre,
      'apellido': apellido,
      'edad': edad,
      'cedula': cedula,
      'correo': correo,
    };
  }

  Future<List> buscarProducto(Bodega bodega, Producto producto) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('productos');

    try {
      QuerySnapshot querySnapshot = await productsCollection
          .where('nombre', isEqualTo: producto.nombre)
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
      print('Error al obtener producto: $e');
      return []; // En caso de error, se devuelve una lista vacía
    }
  }

  Future<void> seleccionarProducto(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('productos');
    try {
      DocumentSnapshot productSnapshot = await productsCollection.doc(id).get();

      if (productSnapshot.exists) {
        Map<String, dynamic> data =
            productSnapshot.data() as Map<String, dynamic>;
        // Haz algo con los datos del documento encontrado
        print('Datos del producto: $data');
      } else {
        print('El producto con ID $id no fue encontrado');
      }
    } catch (e) {
      print('Error al obtener el producto: $e');
    }
    // Producto selectedProduct = Producto(idProducto: idProducto, idCategoria: idCategoria, codigo: codigo, nombre: nombre, fechaElaboracion: fechaElaboracion, fechaCaducidad: fechaCaducidad, descripcion: descripcion, precio: precio, cantidad: cantidad, bodega: bodega, proveedor: proveedor, estado: estado)
  }

  Future<bool> comprobarExistencia(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('productos');
    try {
      DocumentSnapshot productSnapshot = await productsCollection.doc(id).get();

      if (productSnapshot.exists) {
        Map<String, dynamic> data =
            productSnapshot.data() as Map<String, dynamic>;
        // Haz algo con los datos del documento encontrado
        print('Datos del producto: $data');
        return true;
      } else {
        print('El producto con ID $id no fue encontrado');
        return false;
      }
    } catch (e) {
      print('Error al obtener el producto: $e');
      return false;
    }
  }

  Future<List> buscarBodega(String distritoId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('bodegas');

    try {
      QuerySnapshot querySnapshot = await productsCollection
          .where('distrito.idDistrito', isEqualTo: distritoId)
          .get();

      List<Bodega> bodegas = querySnapshot.docs.map((doc) {
        return Bodega(
          nombre: doc["nombre"] ?? "",
          bodeguero: doc["idProducto"] ?? "",
          capacidadAlmacenamiento: doc["capacidadAlmacenamiento"] ?? 0,
          distrito: Distrito.fromJson(doc["distrito"] ?? {}),
          idBodega: doc["idBodega"] ?? "",
          ubicacion: doc["ubicacion"] ?? "",
        );
      }).toList();

      return bodegas;
    } catch (e) {
      print('Error al obtener producto: $e');
      return []; // En caso de error, se devuelve una lista vacía
    }
  }

  Future<void> asignarBodega(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productsCollection = firestore.collection('bodegas');
    try {
      DocumentSnapshot productSnapshot = await productsCollection.doc(id).get();

      if (productSnapshot.exists) {
        Map<String, dynamic> data =
            productSnapshot.data() as Map<String, dynamic>;
        // Haz algo con los datos del documento encontrado
        print('Datos del producto: $data');
        var bodega =
            Bodega.fromJson(productSnapshot.data() as Map<String, dynamic>);
      } else {
        print('la bodega con ID $id no fue encontrado');
      }
    } catch (e) {
      print('Error al obtener el producto: $e');
    }
  }

  Map ingresarCantidadRetirar(int catidad, Producto producto) {
    if ((producto.cantidad - catidad) >= 0) {
      return {"mns": "cantidad requerida exede a la existente"};
    } else {
      producto.cantidad -= catidad;
      return {"mns": "retiro existoso"};
    }
  }

  void generarOrdenSalida() {}
  void generarReportes(Bodega bodega) {
    print('Generando reporte para ${bodega}');
    print('Descripción: ${bodega}');
    print('Cantidad en stock: ${bodega}');
  }
}
