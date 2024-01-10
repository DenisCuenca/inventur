import 'package:inventur/models/producto.dart';

class Dispositivo extends Producto {
  String dispositivoCalidad;
  String tipoDispositivo;

  Dispositivo({
    required this.dispositivoCalidad,
    required this.tipoDispositivo,
    required super.idProducto,
    required super.idCategoria,
    required super.codigo,
    required super.nombre,
    required super.fechaElaboracion,
    required super.fechaCaducidad,
    required super.descripcion,
    required super.precio,
    required super.cantidad,
    required super.bodega,
    required super.proveedor,
    required super.estado,
  });

  void realizarPruebaCalidad() {}
  void enviarNotificacion() {}
}
