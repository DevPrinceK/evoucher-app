import 'dart:math';

import 'package:evoucher/screens/voucher_details.dart';
import 'package:flutter/material.dart';

class VoucherItemCard extends StatelessWidget {
  final String voucherID;
  final String voucherImage;
  final String voucherCreator;
  final String voucherDate;
  final String eventName;
  const VoucherItemCard({
    super.key,
    required this.voucherID,
    this.voucherImage = 'assets/images/evoucher-logo.png',
    required this.voucherCreator,
    required this.voucherDate,
    required this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoucherDetailScreen(
              voucherName: eventName,
              voucherID: voucherID,
              voucherDate: voucherDate,
              voucherCreator: voucherCreator,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 65,
                height: 65,
                child: Image(
                  image: AssetImage(voucherImage),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(voucherID),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
