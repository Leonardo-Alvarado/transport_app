import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final BookingService _bookingService = BookingService();

  // Método para enviar la reserva al backend
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Crear una nueva reserva
      Booking newBooking = Booking(
        id: '', // El ID lo asigna el backend
        clientName: _clientNameController.text,
        origin: _originController.text,
        destination: _destinationController.text,
        status: 'Pendiente', // Se puede personalizar según el estado de la reserva
      );

      try {
        // Llamar al servicio para crear la reserva
        await _bookingService.createBooking(newBooking);
        // Volver a la pantalla principal después de crear la reserva
        Navigator.pop(context);
      } catch (e) {
        print('Error al crear la reserva: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacer una Reserva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para el nombre del cliente
              TextFormField(
                controller: _clientNameController,
                decoration: InputDecoration(labelText: 'Nombre del Cliente'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              // Campo para el origen
              TextFormField(
                controller: _originController,
                decoration: InputDecoration(labelText: 'Origen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el origen';
                  }
                  return null;
                },
              ),
              // Campo para el destino
              TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(labelText: 'Destino'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el destino';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Botón para enviar el formulario
              ElevatedButton(
                onPressed: _submit,
                child: Text('Confirmar Reserva'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
