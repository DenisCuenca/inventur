import 'package:inventur/models/producto.dart';

class InsumoMedico extends Producto {
  int registroSanitario;
  String tipoInsumoM;

  InsumoMedico({
    required this.registroSanitario,
    required this.tipoInsumoM,
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

  // Métodos de la clase InsumoMedico
//  void verificarRegistroSanitario() {}
//  void almacenarInsumo() {}
}
