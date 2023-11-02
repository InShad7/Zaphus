import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zaphus/view/product_expired/product_expired.dart';
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
                final barcode = provider.barcodeController.text;
                if (barcode.isEmpty || barcode != '123' && barcode != '341') {
                  provider.validationSuccess = false;
                  Fluttertoast.showToast(
                    msg: 'Invalid barcode',
                    backgroundColor: Colors.red,
                    gravity: ToastGravity.BOTTOM,
                  );
                  return;
                }

                if (!provider.barcodeList.contains(barcode)) {
                  if (barcode == '123' || barcode == '341') {
                    provider.validationSuccess = true;
                    provider.loadFromDB();
                  } else {
                    provider.validationSuccess = false;
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: 'Barcode expired!!',
                    backgroundColor: Colors.red,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              child: const Text('View products'),
            ),
            Visibility(
              visible: provider.validationSuccess &&
                  provider.barcodeController.text.isNotEmpty,
              child: ListView.builder(
                itemCount: provider.productList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final productId = provider.productList[index];
                  final product = provider.products!
                      .firstWhere((product) => product['id'] == productId);
                  return ItemCard(product: product);
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: provider.productLoaded ? const CheckOutBtn() : null,
    );
  }
}
