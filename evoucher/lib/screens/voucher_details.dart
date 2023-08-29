import 'package:evoucher/components/btmNavBar.dart';
import 'package:flutter/material.dart';

class VoucherDetailScreen extends StatelessWidget {
  final String voucherName;
  final String voucherID;
  final String voucherDate;
  final String voucherCreator;
  const VoucherDetailScreen({
    super.key,
    required this.voucherName,
    required this.voucherID,
    required this.voucherDate,
    required this.voucherCreator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(voucherName),
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
                  const Text("Voucher ID"),
                  const Text(
                    "EV202308191403",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Event Name"),
                  Text(
                    voucherName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Amount"),
                  const Text(
                    "45.00",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
