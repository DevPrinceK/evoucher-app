import 'package:flutter/material.dart';

class PrilfeItem extends StatelessWidget {
  final String title;
  const PrilfeItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
          height: 60,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
