import 'package:flutter/material.dart';

class ProductExpired extends StatelessWidget {
  const ProductExpired({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Barcode expired!!'),
      ),
    );
  }
}
