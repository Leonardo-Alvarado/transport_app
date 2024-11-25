class Booking {
  final String id;
  final String clientName;
  final String origin;
  final String destination;
  final String status;

  Booking({
    required this.id,
    required this.clientName,
    required this.origin,
    required this.destination,
    required this.status,
  });

  // Convertir de JSON a Booking
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      clientName: json['clientName'],
      origin: json['origin'],
      destination: json['destination'],
      status: json['status'],
    );
  }

  // Convertir de Booking a JSON
  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'origin': origin,
      'destination': destination,
      'status': status,
    };
  }
}
