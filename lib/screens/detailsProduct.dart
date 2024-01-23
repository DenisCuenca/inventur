import 'package:flutter/material.dart';

class DetailsProduct extends StatefulWidget {
  final Producto producto;

  DetailsProduct({required this.producto});

  @override
  _DetailsProductState createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  late Producto _producto;
  bool _editable = false;

  @override
  void initState() {
    super.initState();
    _producto = widget.producto;
  }

  void _enableEditing() {
    setState(() {
      _editable = true;
    });
  }

  void _saveChanges() {
    // Aquí puedes agregar la lógica para guardar los cambios en la base de datos

    setState(() {
      _editable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_producto.nombre),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetail('Código:', _producto.codigo),
            buildDetail('Nombre:', _producto.nombre),
            buildDetail(
                'Fecha de caducidad:', _producto.fechaCaducidad.toString()),
            buildDetail('Descripción:', _producto.descripcion),
            buildDetail(
                'Fecha de elaboración:', _producto.fechaElaboracion.toString()),
            buildDetail('Precio:', '\$${_producto.precio.toString()}'),
            buildDetail('Cantidad:', _producto.cantidad.toString()),
            buildDetail('Bodega:', _producto.bodega),
            buildDetail('Proveedor:', _producto.proveedor),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _editable ? _saveChanges : _enableEditing,
                  child: Text(_editable ? 'Guardar' : 'Modificar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Atrás'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label $value',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}

class Producto {
  String id;
  String categoria;
  String codigo;
  String nombre;
  DateTime fechaCaducidad;
  String descripcion;
  DateTime fechaElaboracion;
  double precio;
  int cantidad;
  String bodega;
  String proveedor;

  Producto({
    required this.id,
    required this.categoria,
    required this.codigo,
    required this.nombre,
    required this.fechaCaducidad,
    required this.descripcion,
    required this.fechaElaboracion,
    required this.precio,
    required this.cantidad,
    required this.bodega,
    required this.proveedor,
  });
}
