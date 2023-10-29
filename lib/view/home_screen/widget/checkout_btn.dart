import 'package:flutter/material.dart';
import 'package:zaphus/view/payment_screen/payment_screen.dart';

class CheckOutBtn extends StatelessWidget {
  const CheckOutBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height / 15,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentScreen(),
              ));
        },
        child: const Text(
          'CheckOut',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
