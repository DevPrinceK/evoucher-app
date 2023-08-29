import 'package:evoucher/components/btmNavBar.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventName;
  final String eventID;
  final String eventDate;
  final String eventCreator;
  const EventDetailScreen({
    super.key,
    required this.eventName,
    required this.eventID,
    required this.eventDate,
    required this.eventCreator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventName),
        backgroundColor: const Color.fromARGB(255, 0x32, 0xB7, 0x68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Event Name"),
                  Text(
                    eventName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Date"),
                  const Text(
                    "2023-08-30",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Creator Name"),
                  const Text(
                    "Prince Samuel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Creator Email"),
                  const Text(
                    "princesamuelpks@gmail.com",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // shape: const ShapeBorder(),
        backgroundColor: Colors.red,
        onPressed: () {},
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
