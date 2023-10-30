import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zaphus/view/utils/color.dart';
import '../../controller/provider/contoller.dart';
import '../login_screen/widget/custom_text_field.dart';
import 'widget/checkout_btn.dart';
import 'widget/name_card.dart';
import 'widget/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ControllerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Zaphus'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopNameCard(),
            MyTextField(
              title: 'Enter barcode to view products',
              myControler: provider.barcodeController,
              isNumber: true,
            ),
            ElevatedButton(
              onPressed: () async {
                if (!provider.paymentDone &&
                    provider.barcodeController.text == '12345') {
                  provider.validationSuccess = true;

                  provider.addProductsToProductList();
                } else {
                  provider.validationSuccess = false;

                  Fluttertoast.showToast(
                    msg: provider.paymentDone
                        ? "Barcode expired !!"
                        : 'Invalid barcode',
                    backgroundColor: Colors.red,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              child: const Text('View products'),
            ),
            Visibility(
              visible: provider.validationSuccess,
              child: ListView.builder(
                itemCount: provider.productList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final productId = provider.productList[index];
                  final product = provider.products
                      .firstWhere((product) => product['id'] == productId);
                  return ItemCard(product: product);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          provider.validationSuccess ? const CheckOutBtn() : null,
    );
  }
}
