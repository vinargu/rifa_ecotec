import 'package:flutter/material.dart';
import '../models/numero_rifa.dart';

class DetalleNumeroScreen extends StatefulWidget {
  final NumeroRifa numero;
  final VoidCallback onReservado;

  const DetalleNumeroScreen({
    Key? key,
    required this.numero,
    required this.onReservado,
  }) : super(key: key);

  @override
  State<DetalleNumeroScreen> createState() => _DetalleNumeroScreenState();
}

class _DetalleNumeroScreenState extends State<DetalleNumeroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Número ${widget.numero.numero.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A5CA5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: widget.numero.reservado
                  ? Colors.redAccent
                  : const Color(0xFF1E88E5),
              child: Text(
                widget.numero.numero.toString().padLeft(2, '0'),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Estado: ${widget.numero.reservado ? "RESERVADO" : "DISPONIBLE"}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.numero.reservado ? Colors.redAccent : const Color(0xFF1E88E5),
              ),
            ),
            const SizedBox(height: 40),
            if (!widget.numero.reservado)
              ElevatedButton.icon(
                onPressed: _mostrarDialogoConfirmacion,
                icon: const Icon(Icons.check_circle),
                label: const Text('Reservar Número'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A5CA5),
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              )
            else
              const Text(
                'Este número ya no está disponible',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar reserva'),
          content: Text(
            '¿Estás seguro de reservar el número ${widget.numero.numero.toString().padLeft(2, '0')}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF0A5CA5)),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.numero.reservado = true;
                });
                widget.onReservado();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF0A5CA5)),
              child: const Text('Reservar'),
            ),
          ],
        );
      },
    );
  }
}