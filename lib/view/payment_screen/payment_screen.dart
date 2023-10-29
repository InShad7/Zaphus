import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:zaphus/controller/provider/contoller.dart';
import 'package:zaphus/view/home_screen/home_screen.dart';

import '../utils/color.dart';
import '../utils/constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    success(context: context, fail: false, response: response);

    Fluttertoast.showToast(
        msg: 'Payment Success', backgroundColor: Colors.green);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    success(context: context, fail: true, response: response);

    Fluttertoast.showToast(msg: 'Payment Failure ', backgroundColor: red);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'ExternalWallet', backgroundColor: blue);
  }

  void makePayment() async {
    var amount = 600;
    var options = {
      'key': 'rzp_test_VFn4UZHRVXFRF6',
      'amount': amount * 100,
      'name': 'Nike Store',
      'description': 'Nike',
      'prefill': {'contact': '12345678', 'email': 'admin@gmail.com'}
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      print("error :::::${e}");
    }
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    makePayment();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void success({fail = false, response, context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final provider = Provider.of<ControllerProvider>(context);

        return AlertDialog(
          backgroundColor: white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          actions: [
            Column(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                    color: white,
                    image: DecorationImage(
                      image: AssetImage(
                        fail ? 'assets/close (1).jpg' : 'assets/tick.png',
                      ),
                    ),
                  ),
                ),
                kHeight20,
                Text(
                  fail ? 'Your order has been cancelled' : 'Order confirmed',
                ),
                kHeight15,
                Text(
                  fail
                      ? '${response.message}'
                      : 'Payment Id: ${response.paymentId}',
                  style: const TextStyle(fontSize: 18),
                ),
                kHeight20,
                kHeight20,
                SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (fail) {
                        [
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          ),
                          provider.validationSuccess = true,
                          provider.rewards = 0,
                        ];
                      } else {
                        [
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          ),
                          provider.validationSuccess = false,
                          provider.barcodeController.clear(),
                          provider.rewards = 600,
                          provider.myCount.clear(),
                          // provider.paymentDone=true,
                          Fluttertoast.showToast(
                            msg:
                                'Wohoo!! You have been rewarded with ${provider.rewards} super coins!',
                            backgroundColor: green,
                          ),
                        ];
                      }
                    },
                    icon: Icon(
                      fail ? Icons.restart_alt_rounded : Icons.home_filled,
                      color: white,
                    ),
                    label: Text(
                      fail ? 'Retry' : 'Home',
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
