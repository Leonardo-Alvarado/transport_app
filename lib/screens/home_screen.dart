import 'package:flutter/material.dart';
import 'booking_screen.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BookingService _bookingService = BookingService();
  List<Booking> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  // Cargar reservas desde el backend
  Future<void> _loadBookings() async {
    try {
      List<Booking> bookings = await _bookingService.getBookings();
      setState(() {
        _bookings = bookings;
      });
    } catch (e) {
      print('Error al cargar las reservas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas de Transporte'),
      ),
      body: ListView.builder(
        itemCount: _bookings.length,
        itemBuilder: (context, index) {
          Booking booking = _bookings[index];
          return ListTile(
            title: Text(booking.clientName),
            subtitle: Text('Origen: ${booking.origin} - Destino: ${booking.destination}'),
            trailing: Text(booking.status),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
