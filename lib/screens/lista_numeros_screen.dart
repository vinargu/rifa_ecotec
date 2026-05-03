import 'package:flutter/material.dart';
import '../models/numero_rifa.dart';
import 'detalle_numero_screen.dart';

class ListaNumerosScreen extends StatefulWidget {
  const ListaNumerosScreen({Key? key}) : super(key: key);

  @override
  State<ListaNumerosScreen> createState() => _ListaNumerosScreenState();
}

class _ListaNumerosScreenState extends State<ListaNumerosScreen> {
  late List<NumeroRifa> numeros;

  @override
  void initState() {
    super.initState();
    // Generar 20 números con estado disponible (reservado = false)
    numeros = List.generate(20, (index) {
      return NumeroRifa(
        id: index,
        numero: index + 1,
        reservado: false,
      );
    });
  }

  void _actualizarLista() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    'Números Disponibles',
    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  centerTitle: true,
  backgroundColor: const Color(0xFF0A5CA5),
),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: numeros.length,
        itemBuilder: (context, index) {
          final numero = numeros[index];
          return GestureDetector(
            onTap: () {
              // Si el número ya está reservado, mostrar mensaje
              if (numero.reservado) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Este número ya está reservado'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              // Navegar al detalle
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleNumeroScreen(
                    numero: numero,
                    onReservado: _actualizarLista,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 5,
              // Color según estado: rojo para reservado, azul claro para disponible
              color: numero.reservado ? Colors.redAccent : const Color(0xFF1E88E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  numero.numero.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}