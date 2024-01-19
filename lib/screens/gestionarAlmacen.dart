import 'package:flutter/material.dart';

class GestionarAlmacen extends StatefulWidget {
  const GestionarAlmacen({Key? key}) : super(key: key);

  @override
  State<GestionarAlmacen> createState() => _GestionarAlmacenState();
}

class _GestionarAlmacenState extends State<GestionarAlmacen> {
  final int _currentIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _productos = [
    {
      'id': 1,
      'nombre': 'Producto A',
      'categoria': 'Electrónica',
      'cantidad': 50,
      'precio': 100.0
    },
    {
      'id': 2,
      'nombre': 'Producto B',
      'categoria': 'Ropa',
      'cantidad': 30,
      'precio': 50.0
    },
    {
      'id': 3,
      'nombre': 'Producto C',
      'categoria': 'Hogar',
      'cantidad': 20,
      'precio': 75.0
    },
  ];

  List<Map<String, dynamic>> _filteredProductos = [];

  @override
  void initState() {
    super.initState();
    _filteredProductos = List.from(_productos);
  }

  void _filterProductos(String query) {
    setState(() {
      _filteredProductos = _productos
          .where((producto) =>
              producto['nombre'].toLowerCase().contains(query.toLowerCase()) ||
              producto['categoria'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/inventur.png',
            width: 120,
          ),
        ),
        backgroundColor: const Color.fromRGBO(48, 153, 161, 1),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Buscar...',
                        border: InputBorder.none,
                      ),
                      onChanged: (query) {
                        _filterProductos(query);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Categoría')),
                  DataColumn(label: Text('Cantidad')),
                  DataColumn(label: Text('Precio')),
                ],
                rows: _filteredProductos
                    .map((producto) => DataRow(
                          cells: [
                            DataCell(Text(producto['id'].toString())),
                            DataCell(Text(producto['nombre'])),
                            DataCell(Text(producto['categoria'])),
                            DataCell(Text(producto['cantidad'].toString())),
                            DataCell(Text(producto['precio'].toString())),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: const Color.fromRGBO(48, 153, 161, 1),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse),
              label: 'Proceso',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Opciones',
            ),
          ],
        ),
      ),
    );
  }
}
