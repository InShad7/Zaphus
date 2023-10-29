import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaphus/controller/provider/contoller.dart';

import '../../utils/color.dart';

class QuantityCounter extends StatelessWidget {
  const QuantityCounter({super.key, this.product});
  final product;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ControllerProvider>(context);
    provider.getCount(product: product);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            provider.decrementQuantity(product: product,context: context);
          },
          icon: const Icon(Icons.remove),
        ),
        Container(
          height: 23,
          width: 23,
          decoration: BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '${provider.count}',
              style: TextStyle(fontSize: 15, color: white),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            provider.incrementQuantity(product: product);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
