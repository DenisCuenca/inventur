import 'package:inventur/models/producto.dart';

class Medicamento extends Producto {
  String contradicciones;
  String indicaciones;
  String tipoMedicamento;

  Medicamento({
    required this.contradicciones,
    required this.indicaciones,
    required this.tipoMedicamento,
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

  // Métodos de la clase Medicamento
//  void verificarContradicciones() {}
//  void proporcionarIndicaciones() {}
}
