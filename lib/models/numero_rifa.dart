class NumeroRifa {
  final int id;
  final int numero;
  bool reservado;

  NumeroRifa({
    required this.id,
    required this.numero,
    this.reservado = false,
  });
}