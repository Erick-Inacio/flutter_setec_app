import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Eventos'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          'Novo Evento',
          style: GoogleFonts.lato(
            color: Colors.deepPurple.shade50,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.deepPurple.shade50,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        // itemCount: ,
        itemBuilder: (build, index) {},
      ),
    );
  }
}
