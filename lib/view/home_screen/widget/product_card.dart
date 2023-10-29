import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaphus/controller/provider/contoller.dart';
import 'package:zaphus/view/home_screen/widget/quantity_counter.dart';

import '../../utils/color.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.product});

  final product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          width: 1,
          color: grey2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width / 2.5,
              color: white,
              child: Image.asset(
                product['image'],
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            product['name'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 30,
                  width: MediaQuery.of(context).size.width / 9,
                  color: yellow,
                  child: Center(
                    child: Text(
                      product['rate'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                QuantityCounter(product: product)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
