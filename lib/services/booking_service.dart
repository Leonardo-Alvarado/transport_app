import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking.dart';

class BookingService {
  static const String _baseUrl = 'http://localhost:5000/api/reservas'; // Cambia la URL si usas un servidor remoto

  // Crear una nueva reserva
  Future<Booking> createBooking(Booking booking) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(booking.toJson()),
    );

    if (response.statusCode == 201) {
      return Booking.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear la reserva');
    }
  }

  // Obtener todas las reservas
  Future<List<Booking>> getBookings() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Booking.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener las reservas');
    }
  }
}
